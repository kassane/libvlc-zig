//! This example need VLC v4+

const std = @import("std");
const vlc = @import("vlc");
const SDL = @import("sdl2");
const log = vlc.vlc_log;

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
    m_media: ?*vlc.Media_player_t,
    m_text_lock: std.Thread.Mutex,

    //SDL context
    m_win: ?*SDL.SDL_Window,
    m_ctx: SDL.SDL_GLContext,

    fn init(self: *Self, window: ?*SDL.SDL_Window) void {
        self.m_win = window;
        const args = [_][*c]const u8{
            "--verbose=4",
        };

        self.m_vlc = vlc.new(std.mem.len(args), &args);

        //VLC opengl context needs to be shared with SDL context
        _ = SDL.SDL_GL_SetAttribute(SDL.SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
        self.m_ctx = SDL.SDL_GL_CreateContext(window);
    }
    fn deinit(self: *Self) void {
        self.stop();
        if (self.m_vlc)
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
            vlc.media_release(self.m_media);
            return false;
        }
        // Define the opengl rendering callbacks
        //vlc.video_set_output_callbacks(self.m_mp, vlc.video_engine_opengl, setup, cleanup, nullptr, resize, swap, make_current, get_proc_address, nullptr, nullptr, this);

        // Play the video
        log.info("play media: {s}.\n", .{url});
        vlc.media_player_play(self.m_mp);
        return true;
    }

    fn stop(self: *Self) void {
        if (self.m_mp) {
            vlc.media_player_release(self.m_mp);
            self.m_mp = null;
        }
        if (self.m_media) {
            vlc.media_release(self.m_vlc, self.m_media);
            self.m_media = null;
        }
    }

    fn getVideoFrame(self: *Self, out_updated: *bool) usize {
        self.m_text_lock.lock();
        defer self.m_text_lock.unlock();

        if (out_updated)
            out_updated.* = m_updated;
        if (m_updated) {
            std.mem.swap(usize, m_idx_swap, m_idx_display);
            m_updated = false;
        }
        return self.m_tex[m_idx_display];
    }

    //fn resize(self: *Self, data: ?*anyopaque, cfg: ?*vlc.video_render_cfg_t, render_cfg: ?*vlc.video_output_cfg_t) bool {
    // VLCVideo* that = static_cast<VLCVideo*>(data);
    // if (cfg->width != that->m_width || cfg->height != that->m_height)
    //     cleanup(data);

    // glGenTextures(3, that->m_tex);
    // glGenFramebuffers(3, that->m_fbo);

    // for (int i = 0; i < 3; i++) {
    //     glBindTexture(GL_TEXTURE_2D, that->m_tex[i]);
    //     glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, cfg->width, cfg->height, 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
    //     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    //     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    //     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    //     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    //     glBindFramebuffer(GL_FRAMEBUFFER, that->m_fbo[i]);
    //     glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, that->m_tex[i], 0);
    // }
    // glBindTexture(GL_TEXTURE_2D, 0);

    // GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);

    // if (status != GL_FRAMEBUFFER_COMPLETE) {
    //     return false;
    // }

    // that->m_width = cfg->width;
    // that->m_height = cfg->height;

    // glBindFramebuffer(GL_FRAMEBUFFER, that->m_fbo[that->m_idx_render]);

    // render_cfg->opengl_format = GL_RGBA;
    // render_cfg->full_range = true;
    // render_cfg->colorspace = libvlc_video_colorspace_BT709;
    // render_cfg->primaries  = libvlc_video_primaries_BT709;
    // render_cfg->transfer   = libvlc_video_transfer_func_SRGB;
    // render_cfg->orientation = libvlc_video_orient_top_left;

    //      return true;
    //   }

    // This callback is called during initialisation.
    // fn setup(void** data, const libvlc_video_setup_device_cfg_t *cfg,
    //                   libvlc_video_setup_device_info_t *out) bool
    // {
    //     VLCVideo* that = static_cast<VLCVideo*>(*data);
    //     that->m_width = 0;
    //     that->m_height = 0;
    //     return true;
    // }

    // This callback is called to release the texture and FBO created in resize
    // fn cleanup(void* data) void
    // {
    //     VLCVideo* that = static_cast<VLCVideo*>(data);
    //     if (that->m_width == 0 && that->m_height == 0)
    //         return;

    //     glDeleteTextures(3, that->m_tex);
    //     glDeleteFramebuffers(3, that->m_fbo);
    // }

    // Decalrations
    const Self = @This();

    const m_width = 0;
    const m_height = 0;
    const m_tex: [3]usize = std.mem.zeroes([3]usize);
    const m_fbo: [3]usize = std.mem.zeroes([3]usize);
    const m_idx_render = 0;
    const m_idx_swap = 1;
    const m_idx_display = 2;
    var m_updated = false;
};

pub fn main() void {
    _ = vertexSource;
    _ = fragmentSource;
}
