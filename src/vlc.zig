const c = @cImport({
    @cInclude("vlc/libvlc.h");
    // @cInclude("vlc/libvlc_media_player.h");
});

pub const Callback_t = c.libvlc_callback_t;
pub const Instance_t = c.libvlc_instance_t;
pub const Event_t = c.libvlc_event_t;
pub const Event_Type_t = c.libvlc_event_type_t;
pub const Event_Manage_t = c.libvlc_event_manager_t;
pub const Time_t = c.libvlc_time_t;
pub const Log_t = c.libvlc_log_t;
pub const Media_t = libvlc_media_t;
pub const Media_player_t = libvlc_media_player_t;

pub const log_level = enum(c_int) {
    LIBVLC_DEBUG = 0,
    LIBVLC_NOTICE = 2,
    LIBVLC_WARNING = 3,
    LIBVLC_ERROR = 4,
};

pub fn getError() [*:0]const u8 {
    return c.libvlc_errmsg();
}
pub fn get_compiler() [*:0]const u8 {
    return c.libvlc_get_compiler();
}
pub fn get_version() [*:0]const u8 {
    return c.libvlc_get_version();
}
pub fn get_changeset() [*:0]const u8 {
    return c.libvlc_get_changeset();
}
pub fn log_get_context(ctx: ?*const Log_t, module: [*c][*:0]const u8, file: [*c][*:0]const u8, line: [*c]c_uint) void {
    c.libvlc_log_get_context(ctx, module, file, line);
}
pub fn log_get_object(ctx: ?*const Log_t, name: [*c][*:0]const u8, header: [*c][*:0]const u8, id: [*c]usize) void {
    c.libvlc_log_get_object(ctx, name, header, id);
}
pub fn log_unset(p_instance: ?*Instance_t) void {
    c.libvlc_log_unset(p_instance);
}
pub fn log_set(p_instance: ?*Instance_t, cb: c.libvlc_log_cb, data: ?*anyopaque) void {
    c.libvlc_log_set(p_instance, cb, data);
}
pub fn log_set_file(p_instance: ?*Instance_t, stream: [*c]c.FILE) void {
    c.libvlc_log_set_file(p_instance, stream);
}
pub fn event_attach(p_event_manager: ?*Event_Manage_t, i_event_type: Event_Type_t, f_callback: Callback_t, user_data: ?*anyopaque) c_int {
    return c.libvlc_event_attach(p_event_manager, i_event_type, f_callback, user_data);
}
pub fn event_detach(p_event_manager: ?*Event_Manage_t, i_event_type: Event_Type_t, f_callback: Callback_t, p_user_data: ?*anyopaque) void {
    c.libvlc_event_detach(p_event_manager, i_event_type, f_callback, p_user_data);
}
pub fn event_type_name(event_type: Event_Type_t) [*:0]const u8 {
    return c.libvlc_event_type_name(event_type);
}
pub fn free(ptr: ?*anyopaque) void {
    c.libvlc_free(ptr);
}
pub fn clearerr() void {
    c.libvlc_clearerr();
}
// pub fn vprinterr(fmt: [*:0]const u8, ap: [*c]c.struct___va_list_tag) [*:0]const u8 {
//     return c.libvlc_vprinterr(fmt, ap);
// }
// pub fn printerr(fmt: [*:0]const u8) [*:0]const u8 {
//     return c.libvlc_printerr(fmt);
// }
pub fn new(argc: c_int, argv: [*c]const [*c]const u8) ?*Instance_t {
    return c.libvlc_new(argc, argv);
}
pub fn release(p_instance: ?*Instance_t) void {
    c.libvlc_release(p_instance);
}
pub fn retain(p_instance: ?*Instance_t) void {
    c.libvlc_retain(p_instance);
}
pub fn add_intf(p_instance: ?*Instance_t, name: [*:0]const u8) c_int {
    return c.libvlc_add_intf(p_instance, name);
}
pub fn set_exit_handler(p_instance: ?*Instance_t, cb: ?*const fn (?*anyopaque) callconv(.C) void, @"opaque": ?*anyopaque) void {
    c.libvlc_set_exit_handler(p_instance, cb, @"opaque");
}
pub fn set_user_agent(p_instance: ?*Instance_t, name: [*:0]const u8, http: [*:0]const u8) void {
    c.libvlc_set_user_agent(p_instance, name, http);
}
pub fn set_app_id(p_instance: ?*Instance_t, id: [*:0]const u8, version: [*:0]const u8, icon: [*:0]const u8) void {
    c.libvlc_set_app_id(p_instance, id, version, icon);
}
pub const libvlc_media_slave_t = extern struct {
    psz_uri: [*c]u8,
    i_type: libvlc_media_slave_type_t,
    i_priority: c_uint,
};
pub const libvlc_media_parsed_status_t = enum(c_uint) {
    libvlc_media_parsed_status_skipped = 1,
    libvlc_media_parsed_status_failed,
    libvlc_media_parsed_status_timeout,
    libvlc_media_parsed_status_done,
};
pub const libvlc_media_slave_type_t = enum(c_uint) {
    libvlc_media_slave_type_subtitle,
    libvlc_media_slave_type_audio,
};
pub const libvlc_state_t = enum(c_int) {
    libvlc_NothingSpecial = 0,
    libvlc_Opening,
    libvlc_Buffering,
    libvlc_Playing,
    libvlc_Paused,
    libvlc_Stopped,
    libvlc_Ended,
    libvlc_Error,
};

pub const libvlc_track_type_t = opaque {};
pub const libvlc_media_type_t = opaque {};
pub const libvlc_renderer_item_t = opaque {};
pub const libvlc_media_parse_flag_t = enum(c_uint) {
    libvlc_media_parse_local = 0x00,
    libvlc_media_parse_network = 0x01,
    libvlc_media_fetch_local = 0x02,
    libvlc_media_fetch_network = 0x04,
    libvlc_media_do_interact = 0x08,
};

pub const libvlc_media_track_t = opaque {};
// pub const libvlc_media_track_t = extern struct {
//     i_codec: u32,
//     i_original_fourcc: u32,
//     i_id: c_int,
//     i_type: libvlc_track_type_t,
//     i_profile: c_int,
//     i_level: c_int,
//     unnamed_0: union_unnamed_37,
//     i_bitrate: c_uint,
//     psz_language: [*c]u8,
//     psz_description: [*c]u8,
// };
pub const libvlc_time_t = i64;
pub const libvlc_media_stats_t = extern struct {
    i_read_bytes: c_int,
    f_input_bitrate: f32,
    i_demux_read_bytes: c_int,
    f_demux_bitrate: f32,
    i_demux_corrupted: c_int,
    i_demux_discontinuity: c_int,
    i_decoded_video: c_int,
    i_decoded_audio: c_int,
    i_displayed_pictures: c_int,
    i_lost_pictures: c_int,
    i_played_abuffers: c_int,
    i_lost_abuffers: c_int,
    i_sent_packets: c_int,
    i_sent_bytes: c_int,
    f_send_bitrate: f32,
};
pub const libvlc_meta_t = enum(c_uint) {
    libvlc_meta_Title,
    libvlc_meta_Artist,
    libvlc_meta_Genre,
    libvlc_meta_Copyright,
    libvlc_meta_Album,
    libvlc_meta_TrackNumber,
    libvlc_meta_Description,
    libvlc_meta_Rating,
    libvlc_meta_Date,
    libvlc_meta_Setting,
    libvlc_meta_URL,
    libvlc_meta_Language,
    libvlc_meta_NowPlaying,
    libvlc_meta_Publisher,
    libvlc_meta_EncodedBy,
    libvlc_meta_ArtworkURL,
    libvlc_meta_TrackID,
    libvlc_meta_TrackTotal,
    libvlc_meta_Director,
    libvlc_meta_Season,
    libvlc_meta_Episode,
    libvlc_meta_ShowName,
    libvlc_meta_Actors,
    libvlc_meta_AlbumArtist,
    libvlc_meta_DiscNumber,
    libvlc_meta_DiscTotal,
};
pub const libvlc_media_open_cb = ?*const fn (?*anyopaque, [*c]?*anyopaque, [*c]u64) callconv(.C) c_int;
pub const libvlc_media_read_cb = ?*const fn (?*anyopaque, [*c]u8, usize) callconv(.C) isize;
pub const libvlc_media_seek_cb = ?*const fn (?*anyopaque, u64) callconv(.C) c_int;
pub const libvlc_media_close_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn libvlc_media_new_location(p_instance: ?*Instance_t, psz_mrl: [*:0]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_new_path(p_instance: ?*Instance_t, path: [*:0]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_new_fd(p_instance: ?*Instance_t, fd: c_int) ?*libvlc_media_t;
pub extern fn libvlc_media_new_callbacks(instance: ?*Instance_t, open_cb: libvlc_media_open_cb, read_cb: libvlc_media_read_cb, seek_cb: libvlc_media_seek_cb, close_cb: libvlc_media_close_cb, @"opaque": ?*anyopaque) ?*libvlc_media_t;
pub extern fn libvlc_media_new_as_node(p_instance: ?*Instance_t, psz_name: [*:0]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_add_option(p_md: ?*libvlc_media_t, psz_options: [*:0]const u8) void;
pub extern fn libvlc_media_add_option_flag(p_md: ?*libvlc_media_t, psz_options: [*:0]const u8, i_flags: c_uint) void;
pub extern fn libvlc_media_retain(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_release(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_get_mrl(p_md: ?*libvlc_media_t) [*c]u8;
pub extern fn libvlc_media_duplicate(p_md: ?*libvlc_media_t) ?*libvlc_media_t;
pub extern fn libvlc_media_get_meta(p_md: ?*libvlc_media_t, e_meta: libvlc_meta_t) [*c]u8;
pub extern fn libvlc_media_set_meta(p_md: ?*libvlc_media_t, e_meta: libvlc_meta_t, psz_value: [*:0]const u8) void;
pub extern fn libvlc_media_save_meta(p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_get_state(p_md: ?*libvlc_media_t) libvlc_state_t;
pub extern fn libvlc_media_get_stats(p_md: ?*libvlc_media_t, p_stats: [*c]libvlc_media_stats_t) c_int;
pub const struct_libvlc_media_list_t = opaque {};
pub extern fn libvlc_media_subitems(p_md: ?*libvlc_media_t) ?*struct_libvlc_media_list_t;
pub extern fn libvlc_media_event_manager(p_md: ?*libvlc_media_t) ?*Event_Manage_t;
pub extern fn libvlc_media_get_duration(p_md: ?*libvlc_media_t) libvlc_time_t;
pub extern fn libvlc_media_parse_with_options(p_md: ?*libvlc_media_t, parse_flag: libvlc_media_parse_flag_t, timeout: c_int) c_int;
pub extern fn libvlc_media_parse_stop(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_get_parsed_status(p_md: ?*libvlc_media_t) libvlc_media_parsed_status_t;
pub extern fn libvlc_media_set_user_data(p_md: ?*libvlc_media_t, p_new_user_data: ?*anyopaque) void;
pub extern fn libvlc_media_get_user_data(p_md: ?*libvlc_media_t) ?*anyopaque;
pub extern fn libvlc_media_tracks_get(p_md: ?*libvlc_media_t, tracks: [*c][*c][*c]libvlc_media_track_t) c_uint;
pub extern fn libvlc_media_get_codec_description(i_type: libvlc_track_type_t, i_codec: u32) [*:0]const u8;
pub extern fn libvlc_media_tracks_release(p_tracks: [*c][*c]libvlc_media_track_t, i_count: c_uint) void;
pub extern fn libvlc_media_get_type(p_md: ?*libvlc_media_t) libvlc_media_type_t;
pub extern fn libvlc_media_slaves_add(p_md: ?*libvlc_media_t, i_type: libvlc_media_slave_type_t, i_priority: c_uint, psz_uri: [*:0]const u8) c_int;
pub extern fn libvlc_media_slaves_clear(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_slaves_get(p_md: ?*libvlc_media_t, ppp_slaves: [*c][*c][*c]libvlc_media_slave_t) c_uint;
pub extern fn libvlc_media_slaves_release(pp_slaves: [*c][*c]libvlc_media_slave_t, i_count: c_uint) void;
const libvlc_media_player_t = opaque {};
const libvlc_media_t = opaque {};
pub const struct_libvlc_equalizer_t = opaque {};
pub const libvlc_equalizer_t = struct_libvlc_equalizer_t;
pub extern fn libvlc_media_player_new(p_libvlc_instance: ?*Instance_t) ?*libvlc_media_player_t;
pub extern fn libvlc_media_player_new_from_media(p_md: ?*libvlc_media_t) ?*libvlc_media_player_t;
pub extern fn libvlc_media_player_release(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_retain(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_set_media(p_mi: ?*libvlc_media_player_t, p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_player_get_media(p_mi: ?*libvlc_media_player_t) ?*libvlc_media_t;
pub extern fn libvlc_media_player_event_manager(p_mi: ?*libvlc_media_player_t) ?*Event_Manage_t;
pub extern fn libvlc_media_player_is_playing(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_play(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_set_pause(mp: ?*libvlc_media_player_t, do_pause: c_int) void;
pub extern fn libvlc_media_player_pause(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_stop(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_set_renderer(p_mi: ?*libvlc_media_player_t, p_item: ?*libvlc_renderer_item_t) c_int;
pub const libvlc_video_lock_cb = ?*const fn (?*anyopaque, [*c]?*anyopaque) callconv(.C) ?*anyopaque;
pub const libvlc_video_unlock_cb = ?*const fn (?*anyopaque, ?*anyopaque, [*c]const ?*anyopaque) callconv(.C) void;
pub const libvlc_video_display_cb = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
pub const libvlc_video_format_cb = ?*const fn ([*c]?*anyopaque, [*c]u8, [*c]c_uint, [*c]c_uint, [*c]c_uint, [*c]c_uint) callconv(.C) c_uint;
pub const libvlc_video_cleanup_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn libvlc_video_set_callbacks(mp: ?*libvlc_media_player_t, lock: libvlc_video_lock_cb, unlock: libvlc_video_unlock_cb, display: libvlc_video_display_cb, @"opaque": ?*anyopaque) void;
pub extern fn libvlc_video_set_format(mp: ?*libvlc_media_player_t, chroma: [*:0]const u8, width: c_uint, height: c_uint, pitch: c_uint) void;
pub extern fn libvlc_video_set_format_callbacks(mp: ?*libvlc_media_player_t, setup: libvlc_video_format_cb, cleanup: libvlc_video_cleanup_cb) void;
pub extern fn libvlc_media_player_set_nsobject(p_mi: ?*libvlc_media_player_t, drawable: ?*anyopaque) void;
pub extern fn libvlc_media_player_get_nsobject(p_mi: ?*libvlc_media_player_t) ?*anyopaque;
pub extern fn libvlc_media_player_set_xwindow(p_mi: ?*libvlc_media_player_t, drawable: u32) void;
pub extern fn libvlc_media_player_get_xwindow(p_mi: ?*libvlc_media_player_t) u32;
pub extern fn libvlc_media_player_set_hwnd(p_mi: ?*libvlc_media_player_t, drawable: ?*anyopaque) void;
pub extern fn libvlc_media_player_get_hwnd(p_mi: ?*libvlc_media_player_t) ?*anyopaque;
pub extern fn libvlc_media_player_set_android_context(p_mi: ?*libvlc_media_player_t, p_awindow_handler: ?*anyopaque) void;
pub extern fn libvlc_media_player_set_evas_object(p_mi: ?*libvlc_media_player_t, p_evas_object: ?*anyopaque) c_int;
