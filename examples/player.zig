const std = @import("std");
const vlc = @import("vlc");
const stdout = std.io.getStdOut().writer();
const strcmp = std.mem.eql;
const strcontain = std.mem.startsWith;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();
    const args = try std.process.argsAlloc(arena_allocator);

    var mp: ?*vlc.Media_player_t = null;
    var m: ?*vlc.Media_t = null;

    var argc: usize = 0;
    while (argc < args.len) {
        argc += 1;
        // Help message
        if (args.len <= 1 or strcmp(u8, args[argc], "-h") or strcmp(u8, args[argc], "--help")) {
            usage() catch @panic("Cannot be print help!");
            return;
        }
        // load the vlc engine
        var inst: ?*vlc.Instance_t = vlc.new(@intCast(c_int, argc), &[_][*c]const u8{"--verbose=2"});
        
        // create a new item
        if (strcmp(u8, args[argc], "--input") or strcmp(u8, args[argc], "-i")) {
            if (args.len < 3) {
                stdout.print("Missing file to exec [argc:{}]!\n", .{args.len}) catch @panic("Cannot print");
                break;
            } else {
                argc += 1;
                // std.debug.print("input: {s}\n", .{args[argc]});

                m = vlc.libvlc_media_new_path(inst, args[argc]);
            }
        }
        if (strcmp(u8, args[argc], "--url") or strcmp(u8, args[argc], "-u")) {
            if (args.len < 3) {
                stdout.print("Missing URL file to exec [argc: {}]!\n", .{args.len}) catch @panic("Cannot print");
                break;
            } else {
                argc += 1;
                // std.debug.print("input: {s}\n", .{args[argc]});

                m = vlc.libvlc_media_new_location(inst, args[argc]);
            }
        }

        // create a media play playing environment
        mp = vlc.libvlc_media_player_new_from_media(m);

        // no need to keep the media now
        vlc.libvlc_media_release(m);

        // play the media_player
        if (vlc.libvlc_media_player_play(mp) < 0) @panic("Cannot be played!");

        std.time.sleep(10);

        // stop playing
        vlc.libvlc_media_player_stop(mp);

        // free the media_player
        vlc.libvlc_media_player_release(mp);

        vlc.release(inst);
        break;
    }
}

fn usage() !void {
    try stdout.print(
        \\cli-player [options]
        \\
        \\Options:
        \\  -i, --input: Open local multimedia [*formats(mp4,mp3,webm,avi,rmvb)],
        \\  -u, --url:   Open online multimedia [*formats(mp4,mp3,webm,avi,rmvb)],
        \\  -h, --help:  This message,
        \\
    , .{});
}
