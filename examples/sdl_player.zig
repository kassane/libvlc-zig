const std = @import("std");
const vlc = @import("vlc");
const SDL = @import("sdl2");
const stdout = std.io.getStdOut().writer();
const strcmp = std.mem.eql;

// SCREEN SIZE
const SCREEN = struct {
    const height: c_int = 600;
    const width: c_int = 800;
    const videoheight: usize = 480;
    const videowidth: usize = 640;
};

const Context = extern struct {
    renderer: ?*SDL.SDL_Renderer,
    surface: ?*SDL.SDL_Surface,
    mutex: ?*SDL.SDL_mutex,
    texture: ?*SDL.SDL_Texture,
    n: c_int,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const args = try std.process.argsAlloc(gpa.allocator());
    defer std.process.argsFree(gpa.allocator(), args);

    const vlc_args = [_][*c]const u8{
        // Debug
        "--verbose=2",
        //"--no-audio", // Don't play audio.
        "--no-xlib", // Don't use Xlib.

        // Apply a video filter.
        //"--video-filter", "sepia",
        //"--sepia-intensity=200"
    };

    var argc: usize = 0;
    while (argc < args.len) {
        argc += 1;
        // Help message
        if (args.len <= 1 or strcmp(u8, args[argc], "-h") or strcmp(u8, args[argc], "--help")) {
            usage() catch @panic("Cannot be print help!");
            return;
        }
        // load the vlc engine
        var inst: ?*vlc.Instance_t = vlc.new(@intCast(c_int, argc), &vlc_args);

        // create a new item
        if (strcmp(u8, args[argc], "--input") or strcmp(u8, args[argc], "-i")) {
            if (args.len < 3) {
                stdout.print("Missing file to exec [argc:{}]!\n", .{args.len}) catch @panic("Cannot print");
                break;
            } else {
                argc += 1;
                SDL_window(inst, vlc.libvlc_media_new_path(inst, @ptrCast([*c]const u8, args[argc].ptr)));
            }
        }
        if (strcmp(u8, args[argc], "--url") or strcmp(u8, args[argc], "-u")) {
            if (args.len < 3) {
                stdout.print("Missing URL file to exec [argc: {}]!\n", .{args.len}) catch @panic("Cannot print");
                break;
            } else {
                argc += 1;
                SDL_window(inst, vlc.libvlc_media_new_location(inst, @ptrCast([*c]const u8, args[argc].ptr)));
            }
        }
        break;
    }
}

fn usage() !void {
    try stdout.print(
        \\sdl-player [options]
        \\
        \\Options:
        \\  -i, --input: Open local multimedia [*formats(mp4,mp3,webm,avi,rmvb)],
        \\  -u, --url:   Open online multimedia [*formats(mp4,mp3,webm,avi,rmvb)],
        \\  -h, --help:  This message,
        \\{s}
    , .{"\n\r"});
}

fn SDL_window(ctx: ?*vlc.Instance_t, file: ?*vlc.Media_t) void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO | SDL.SDL_INIT_EVENTS | SDL.SDL_INIT_AUDIO) < 0)
        sdlPanic();
    defer SDL.SDL_Quit();

    var window = SDL.SDL_CreateWindow(
        "Zig - VLC Player",
        SDL.SDL_WINDOWPOS_CENTERED,
        SDL.SDL_WINDOWPOS_CENTERED,
        SCREEN.width,
        SCREEN.height,
        SDL.SDL_WINDOW_SHOWN,
    ) orelse sdlPanic();

    defer _ = SDL.SDL_DestroyWindow(window);
    defer vlc.release(ctx);

    var context: Context = undefined;

    context.renderer = SDL.SDL_CreateRenderer(window, -1, SDL.SDL_RENDERER_ACCELERATED) orelse sdlPanic();
    context.texture = SDL.SDL_CreateTexture(context.renderer, SDL.SDL_PIXELFORMAT_BGR565, SDL.SDL_TEXTUREACCESS_STREAMING, SCREEN.videowidth, SCREEN.videoheight);

    context.mutex = SDL.SDL_CreateMutex();

    // create a media play playing environment
    var mp: ?*vlc.Media_player_t = vlc.libvlc_media_player_new_from_media(file);

    // no need to keep the media now
    defer vlc.libvlc_media_release(file);

    vlc.libvlc_video_set_callbacks(mp, lock, unlock, display, &context);
    vlc.libvlc_video_set_format(mp, "RV16", SCREEN.videowidth, SCREEN.videoheight, SCREEN.videowidth * @as(c_int, 2));

    // play the media_player
    if (vlc.libvlc_media_player_play(mp) < 0) @panic("Cannot be played!");

    mainLoop: while (true) {
        var ev: SDL.SDL_Event = undefined;
        while (SDL.SDL_PollEvent(&ev) != 0) {
            if (ev.type == SDL.SDL_QUIT)
                break :mainLoop;
        }
        var rect: SDL.SDL_Rect = undefined;
        rect.w = SCREEN.videowidth;
        rect.h = SCREEN.videoheight;
        // rect.x = ((1 + 5 * std.math.sin(@as(i32,delay) * 1)) * (SCREEN.width - SCREEN.videoheight) / 2);
        // rect.y = ((1 + 5 * std.math.cos(@as(i32,delay) * 1)) * (SCREEN.height - SCREEN.videowidth) / 2);

        rect.x = @floatToInt(c_int, ((1.0 + (0.5 * std.math.sin(0.03 * @intToFloat(f64, context.n)))) * @intToFloat(f64, @as(c_int, SCREEN.height) - @as(c_int, SCREEN.videoheight))) / @intToFloat(f64, @as(c_int, 2)));
        rect.y = @floatToInt(c_int, ((1.0 + (0.5 * std.math.cos(0.03 * @intToFloat(f64, context.n)))) * @intToFloat(f64, @as(c_int, SCREEN.width) - @as(c_int, SCREEN.videowidth))) / @intToFloat(f64, @as(c_int, 2)));

        _ = SDL.SDL_SetRenderDrawColor(context.renderer, 0, 80, 0, 255);
        _ = SDL.SDL_RenderClear(context.renderer);
        _ = SDL.SDL_RenderCopy(context.renderer, SDL.SDL_CreateTextureFromSurface(context.renderer, context.surface), null, &rect);
        SDL.SDL_RenderPresent(context.renderer);
        _ = SDL.SDL_UnlockMutex(context.mutex);

        _ = SDL.SDL_Delay(10);
    }

    _ = vlc.sleep(40);

    // stop playing
    vlc.libvlc_media_player_stop(mp);

    // free the media_player
    defer vlc.libvlc_media_player_release(mp);

    // Close window and clean up libSDL.
    _ = SDL.SDL_DestroyMutex(context.mutex);
    _ = SDL.SDL_DestroyRenderer(context.renderer);
}

fn sdlPanic() noreturn {
    const str = @as(?[*:0]const u8, SDL.SDL_GetError()) orelse "unknown error";
    @panic(std.mem.sliceTo(str, 0));
}

// VLC prepares to render a video frame.
fn lock(data: ?*anyopaque, p_pixels: [*c]?*anyopaque) callconv(.C) ?*anyopaque {
    const c: ?*Context = @ptrCast(*Context, @alignCast(std.meta.alignment(*Context), data));

    var pitch: c_int = 0;
    _ = SDL.SDL_LockMutex(c.?.mutex);
    _ = SDL.SDL_LockTexture(c.?.texture, null, p_pixels, &pitch);

    return null; // Picture identifier, not needed here.
}

// VLC just rendered a video frame.
fn unlock(data: ?*anyopaque, id: ?*anyopaque, p_pixels: [*c]const ?*anyopaque) callconv(.C) void {
    _ = id;
    const c: ?*Context = @ptrCast(*Context, @alignCast(std.meta.alignment(*Context), data));

    const pixels: [*c]u16 = @ptrCast([*c]u16, @alignCast(std.meta.alignment([*c]u16), p_pixels.*));

    // We can also render stuff.
    var x: usize = 10;
    var y: usize = 10;
    while (y < 40) : (y += 1) {
        while (x < 40) : (x += 1) {
            if (x < 13 or y < 13 or x > 36 or y > 36) {
                pixels[y * SCREEN.videowidth + x] = 0xffff;
            } else {
                // RV16 = 5+6+5 pixels per color, BGR.
                pixels[y * SCREEN.videoheight + x] = 0x02ff;
            }
        }
    }

    _ = SDL.SDL_UnlockTexture(c.?.texture);
    _ = SDL.SDL_UnlockMutex(c.?.mutex);
}

// VLC wants to display a video frame.
fn display(data: ?*anyopaque, id: ?*anyopaque) callconv(.C) void {
    _ = id;
    const c: ?*Context = @ptrCast(*Context, @alignCast(std.meta.alignment(*Context), data));
    _ = c;
}
