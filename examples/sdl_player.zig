//! This example need VLC v4+

const std = @import("std");
const vlc = @import("vlc");
const SDL = @import("sdl2");
const log = vlc.vlc_log;
const stdout = std.io.getStdOut().writer();
const colorSpace = vlc.VideoColorSpace_t;
const primaries = vlc.VideoPrimaries_t;
const videoTransfer = vlc.VideoTransferFunc_t;
const videoOrient = vlc.VideoOrient_t;

// Shader sources
// const vertexSource = [_][]const u8{
//     "attribute vec4 a_position;    \n",
//     "attribute vec2 a_uv;          \n",
//     "varying vec2 v_TexCoordinate; \n",
//     "void main()                   \n",
//     "{                             \n",
//     "    v_TexCoordinate = a_uv;   \n",
//     "    gl_Position = vec4(a_position.xyz, 1.0);  \n",
//     "}                             \n",
// };

// const fragmentSource = [_][]const u8{
//     "uniform sampler2D u_videotex; \n",
//     "varying vec2 v_TexCoordinate; \n",
//     "void main()                   \n",
//     "{                             \n",
//     "    gl_FragColor = texture2D(u_videotex, v_TexCoordinate); \n",
//     "}                             \n",
// };

// Shader sources
const vertexSource: [*:0]const u8 =
    \\attribute vec4 a_position;    \n
    \\attribute vec2 a_uv;          \n
    \\varying vec2 v_TexCoordinate; \n
    \\void main()                   \n
    \\{                             \n
    \\    v_TexCoordinate = a_uv;   \n
    \\    gl_Position = vec4(a_position.xyz, 1.0);  \n
    \\}                             \n
;

const fragmentSource: [*:0]const u8 =
    \\uniform sampler2D u_videotex; \n
    \\varying vec2 v_TexCoordinate; \n
    \\void main()                   \n
    \\{                             \n
    \\    gl_FragColor = texture2D(u_videotex, v_TexCoordinate); \n
    \\}                             \n
;

const VLCVideo = struct {
    // Fields

    //VLC objects
    m_vlc: ?*vlc.Instance_t,
    m_mp: ?*vlc.Media_player_t,
    m_media: ?*vlc.Media_t,
    m_text_lock: std.Thread.Mutex,

    //SDL context
    m_win: ?*SDL.SDL_Window,
    m_ctx: SDL.SDL_GLContext,

    fn init(self: *Self, window: ?*SDL.SDL_Window) void {
        self.m_win = window;
        const args = [_][*c]const u8{
            "--verbose=4",
        };
        const argc = @intCast(c_int, std.mem.len(args));

        self.m_vlc = vlc.new(argc, &args);

        //VLC opengl context needs to be shared with SDL context
        _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
        self.m_ctx = SDL.SDL_GL_CreateContext(window);
        // return self;
    }
    fn deinit(self: *Self) void {
        self.stop();
        if (self.m_vlc) |_|
            vlc.release(self.m_vlc);
    }

    fn playMedia(self: *Self, url: [*:0]const u8) bool {
        self.m_media = vlc.media_new_location(self.m_vlc, url);
        if (self.m_media) |_| {
            log.err("unable to create media: {s}.\n", .{url});
            return false;
        }
        self.m_mp = vlc.media_player_new_from_media(self.m_vlc, self.m_media);
        if (self.m_mp) |_| {
            log.err("unable to create media player.\n", .{});
            vlc.media_release(self.m_vlc, self.m_media);
            return false;
        }
        vlc.video_set_output_callbacks(self.m_mp, vlc.video_engine_opengl, setup, cleanup, null, resize, swap, make_current, get_proc_address, null, null, self);

        // Play the video
        log.info("play media: {s}.\n", .{url});
        vlc.media_player_play(self.m_mp);
        return true;
    }

    fn stop(self: *Self) void {
        if (self.m_mp) |_| {
            vlc.media_player_release(self.m_mp);
            self.m_mp = null;
        }
        if (self.m_media) |_| {
            vlc.media_release(self.m_vlc, self.m_media);
            self.m_media = null;
        }
    }

    fn getVideoFrame(self: *Self, out_updated: *bool) usize {
        self.m_text_lock.lock();
        defer self.m_text_lock.unlock();

        if (out_updated.*)
            out_updated.* = m_updated;
        if (m_updated) {
            std.mem.swap(usize, &m_idx_swap, &m_idx_display);
            m_updated = false;
        }
        return self.m_tex[m_idx_display];
    }

    fn resize(self: *Self, data: ?*anyopaque, cfg: ?*vlc.video_render_cfg_t, render_cfg: ?*vlc.video_output_cfg_t) bool {
        if (cfg.width != self.m_width or cfg.height != self.m_height)
            cleanup(data);

        SDL.glGenTextures(3, self.m_tex);
        SDL.glGenFramebuffers(3, self.m_fbo);

        var index: usize = 0;

        while (index < 3) : (index += 1) {
            SDL.glBindTexture(SDL.GL_TEXTURE_2D, self.m_tex[index]);
            SDL.glTexImage2D(SDL.GL_TEXTURE_2D, 0, SDL.GL_RGBA, cfg.width, cfg.height, 0, SDL.GL_RGBA, SDL.GL_UNSIGNED_BYTE, null);
            SDL.glTexParameteri(SDL.GL_TEXTURE_2D, SDL.GL_TEXTURE_WRAP_S, SDL.GL_CLAMP_TO_EDGE);
            SDL.glTexParameteri(SDL.GL_TEXTURE_2D, SDL.GL_TEXTURE_WRAP_T, SDL.GL_CLAMP_TO_EDGE);
            SDL.glTexParameteri(SDL.GL_TEXTURE_2D, SDL.GL_TEXTURE_MIN_FILTER, SDL.GL_LINEAR);
            SDL.glTexParameteri(SDL.GL_TEXTURE_2D, SDL.GL_TEXTURE_MAG_FILTER, SDL.GL_LINEAR);

            SDL.glBindFramebuffer(SDL.GL_FRAMEBUFFER, self.m_fbo[index]);
            SDL.glFramebufferTexture2D(SDL.GL_FRAMEBUFFER, SDL.GL_COLOR_ATTACHMENT0, SDL.GL_TEXTURE_2D, self.m_tex[index], 0);
        }
        SDL.glBindTexture(SDL.GL_TEXTURE_2D, 0);

        const status: SDL.GLenum = SDL.glCheckFramebufferStatus(SDL.GL_FRAMEBUFFER);

        if (status != SDL.GL_FRAMEBUFFER_COMPLETE) {
            return false;
        }

        self.m_width = cfg.width;
        self.m_height = cfg.height;

        SDL.glBindFramebuffer(SDL.GL_FRAMEBUFFER, self.m_fbo[self.m_idx_render]);

        render_cfg.opengl_format = SDL.GL_RGBA;
        render_cfg.full_range = true;
        render_cfg.colorspace = colorSpace.BT709;
        render_cfg.primaries = primaries.BT709;
        render_cfg.transfer = videoTransfer.SRGB;
        render_cfg.orientation = videoOrient.top_left;

        return true;
    }

    fn setup(self: *Self, cfg: ?*const vlc.VideoSetupDeviceCfg_t, out: ?*vlc.VideoSetupDeviceInfo_t) bool {
        _ = out;
        _ = cfg;
        self.m_width = 0;
        self.m_height = 0;
        return true;
    }

    fn cleanup(self: *Self) void {
        if (self.m_width == 0 and self.m_height == 0)
            return;
        SDL.glDeleteTextures(3, self.m_tex);
        SDL.glDeleteFramebuffers(3, self.m_fbo);
    }

    fn swap(self: *Self) void {
        self.m_text_lock.lock();
        self.m_updated = true;
        std.mem.swap(usize, self.m_idx_swap, self.m_idx_render);
        SDL.glBindFramebuffer(SDL.GL_FRAMEBUFFER, self.m_fbo[self.m_idx_render]);
        self.m_text_lock.unlock();
    }

    fn make_current(self: *Self, current: bool) bool {
        return switch (current) {
            true => SDL.SDL_GL_MakeCurrent(self.m_win, self.m_ctx) == 0,
            else => SDL.SDL_GL_MakeCurrent(self.m_win, 0) == 0,
        };
    }

    fn get_proc_address(self: *Self, current: [*:0]const u8) void {
        _ = self;
        return SDL.SDL_GL_GetProcAddress(current);
    }

    // Decalrations
    const Self = @This();

    const m_width: u32 = 0;
    const m_height: u32 = 0;
    const m_tex: [3]usize = std.mem.zeroes([3]usize);
    const m_fbo: [3]usize = std.mem.zeroes([3]usize);
    const m_idx_render: usize = 0;
    var m_idx_swap: usize = 1;
    var m_idx_display: usize = 2;
    var m_updated: bool = false;
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const args = try std.process.argsAlloc(gpa.allocator());
    defer std.process.argsFree(gpa.allocator(), args);
    const argc = args.len;

    // Help message
    if (args.len < 2 or std.mem.eql(u8, args[argc], "-h") or std.mem.eql(u8, args[argc], "--help")) {
        try usage();
        return;
    }

    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO | SDL.SDL_INIT_EVENTS | SDL.SDL_INIT_AUDIO) < 0)
        sdlPanic();
    defer SDL.SDL_Quit();

    var window = SDL.SDL_CreateWindow(
        "SDL2 Player",
        SDL.SDL_WINDOWPOS_CENTERED,
        SDL.SDL_WINDOWPOS_CENTERED,
        640,
        480,
        SDL.SDL_WINDOW_OPENGL | SDL.SDL_WINDOW_SHOWN,
    ) orelse sdlPanic();
    defer _ = SDL.SDL_DestroyWindow(window);

    _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_CONTEXT_MINOR_VERSION, 0);
    _ = SDL.SDL_GL_SetSwapInterval(0);
    _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_DOUBLEBUFFER, 1);
    _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_DEPTH_SIZE, 24);

    const glc: SDL.SDL_GLContext = SDL.SDL_GL_CreateContext(window);
    _ = glc;

    var vlc_sdl: *VLCVideo = undefined;
    vlc_sdl.init(window);
    defer vlc_sdl.deinit();

    // Create Vertex Array Object
    // const vao: u32 = undefined;
    // SDL.glGenVertexArrays(1, &vao);
    // SDL.glBindVertexArray(vao);

    // Create a Vertex Buffer Object and copy the vertex data to it
    // const vbo: u32 = undefined;
    // SDL.glGenBuffers(1, &vbo);

    //vertex X, vertex Y, UV X, UV Y
    const vertices: [16]f32 = [16]f32{
        -0.5, 0.5,  0.0, 1.0,
        -0.5, -0.5, 0.0, 0.0,
        0.5,  0.5,  1.0, 1.0,
        0.5,  -0.5, 1.0, 0.0,
    };
    _ = vertices;

    // SDL.glBindBuffer(SDL.GL_ARRAY_BUFFER, vbo);
    // SDL.glBufferData(SDL.GL_ARRAY_BUFFER, vertices.len, vertices, SDL.GL_STATIC_DRAW);

    // Create and compile the vertex shader
    // const vertexShader: u32 = SDL.glCreateShader(SDL.GL_VERTEX_SHADER);
    // SDL.glShaderSource(vertexShader, 1, &vertexSource, null);
    // SDL.glCompileShader(vertexShader);

    // Create and compile the fragment shader
    // const fragmentShader: u32 = SDL.glCreateShader(SDL.GL_FRAGMENT_SHADER);
    // SDL.glShaderSource(fragmentShader, 1, &fragmentSource, null);
    // SDL.glCompileShader(fragmentShader);

    var renderer = SDL.SDL_CreateRenderer(window, -1, SDL.SDL_RENDERER_ACCELERATED | SDL.SDL_RENDERER_TARGETTEXTURE) orelse sdlPanic();
    defer _ = SDL.SDL_DestroyRenderer(renderer);

    // {
    //     var shader: []u32 = [_]32{ vertexShader, fragmentShader };
    //     const shaderName = [_][]const u8{ "vertex", "fragment" };
    //     var index: usize = 0;
    //     while (index < 2) : (index += 1) {
    //         var len: c_int = 0;
    //         SDL.glGetShaderiv(shader[index], SDL.GL_INFO_LOG_LENGTH, &len);
    //         if (len <= 1)
    //             continue;
    //         var infoLog: [len]u8 = undefined;
    //         var charsWritten: c_int = 0;
    //         SDL.glGetShaderInfoLog(shader[index], len, &charsWritten, infoLog);
    //         log.info("{s} shader info log: {s}\n", .{ shaderName[index], infoLog });

    //         var status: c_int = SDL.GL_TRUE;
    //         SDL.glGetShaderiv(shader[index], SDL.GL_COMPILE_STATUS, &status);
    //         if (status == SDL.GL_FALSE) {
    //             log.err("compile {s} shader failed\n", .{shaderName[index]});
    //             SDL.SDL_DestroyWindow(window);
    //             SDL.SDL_Quit();
    //             return;
    //         }
    //     }
    // }

    // Link the vertex and fragment shader into a shader program
    // const shaderProgram: i32 = SDL.glCreateProgram();
    // SDL.glAttachShader(shaderProgram, vertexShader);
    // SDL.glAttachShader(shaderProgram, fragmentShader);
    // SDL.glLinkProgram(shaderProgram);

    // {
    //     var len: c_int = 0;
    //     SDL.glGetProgramiv(shaderProgram, SDL.GL_INFO_LOG_LENGTH, &len);
    //     if (len > 1) {
    //         var infoLog: [len]u8 = undefined;
    //         var charsWritten: c_int = 0;
    //         SDL.glGetProgramInfoLog(shaderProgram, len, &charsWritten, &infoLog);
    //         log.info("shader program: {s}\n", .{infoLog});
    //     }

    //     var status: c_int = SDL.GL_TRUE;
    //     SDL.glGetProgramiv(shaderProgram, SDL.GL_LINK_STATUS, &status);
    //     if (status == SDL.GL_FALSE) {
    //         SDL.SDL_DestroyWindow(window);
    //         SDL.SDL_Quit();
    //         @panic("unable to use program\n");
    //     }
    // }

    // SDL.glUseProgram(shaderProgram);

    // Specify the layout of the vertex data
    // const posAttrib: i32 = SDL.glGetAttribLocation(shaderProgram, "a_position");
    // SDL.glEnableVertexAttribArray(posAttrib);
    // SDL.glVertexAttribPointer(posAttrib, 2, SDL.GL_FLOAT, SDL.GL_FALSE, 4 * @sizeOf(f32), 0);

    // // Specify the layout of the vertex data
    // const uvAttrib: i32 = SDL.glGetAttribLocation(shaderProgram, "a_uv");
    // SDL.glEnableVertexAttribArray(uvAttrib);
    // SDL.glVertexAttribPointer(uvAttrib, 2, SDL.GL_FLOAT, SDL.GL_FALSE, 4 * @sizeOf(f32), @ptrCast(*anyopaque, 2 * @sizeOf(f32)));

    // // Specify the texture of the video
    // const textUniform: u32 = SDL.glGetUniformLocation(shaderProgram, "u_videotex");
    // SDL.glActiveTexture(SDL.GL_TEXTURE0);
    // SDL.glUniform1i(textUniform, 0);

    //start playing the video
    if (!vlc_sdl.playMedia(args[1])) {
        SDL.SDL_DestroyWindow(window);
        SDL.SDL_Quit();
        return;
    }

    var updated: bool = false;

    mainLoop: while (true) {
        var ev: SDL.SDL_Event = undefined;
        while (SDL.SDL_PollEvent(&ev) != 0) {
            if (std.math.compare(ev.type,.eq, SDL.SDL_QUIT))
                break :mainLoop;
        }

        _ = SDL.SDL_SetRenderDrawColor(renderer, 0xF7, 0xA4, 0x1D, 0xFF);
        _ = SDL.SDL_RenderClear(renderer);

        SDL.SDL_RenderPresent(renderer);

        // Clear the screen to black
        // SDL.glClearColor(0.0, 0.0, 0.0, 1.0);
        // SDL.glClear(SDL.GL_COLOR_BUFFER_BIT);

        // Get the current video texture and bind it
        const tex: u32 = vlc_sdl.getVideoFrame(&updated);
        SDL.glBindTexture(SDL.GL_TEXTURE_2D, tex);

        // Draw the video rectangle
        SDL.glDrawArrays(SDL.GL_TRIANGLE_STRIP, 0, 4);
        SDL.glBindTexture(SDL.GL_TEXTURE_2D, 0);

        SDL.SDL_GL_SwapWindow(window);
    }
    vlc_sdl.stop();
}

fn usage() !void {
    try stdout.print(
        \\sdl-player [options]
        \\
        \\Options:
        \\  -i, --input: Open local multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -u, --url:   Open online multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -h, --help:  This message
        \\{s}
    , .{"\n\r"});
}

fn sdlPanic() noreturn {
    const str = @as(?[*:0]const u8, SDL.SDL_GetError()) orelse "unknown error";
    @panic(std.mem.sliceTo(str, 0));
}
