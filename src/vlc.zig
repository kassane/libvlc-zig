//! BSD 2-Clause License
//! Copyright (c) 2022, Matheus Catarino França
//
//! Redistribution and use in source and binary forms, with or without
//! modification, are permitted provided that the following conditions are met:
//! 1. Redistributions of source code must retain the above copyright notice, this
//!    list of conditions and the following disclaimer.
//! 2. Redistributions in binary form must reproduce the above copyright notice,
//!    this list of conditions and the following disclaimer in the documentation
//!    and/or other materials provided with the distribution.

const std = @import("std");
const builtin = @import("builtin");

const c = @cImport({
    @cInclude("vlc/vlc.h");
    @cInclude("vlc/libvlc_version.h");
    @cDefine("struct_a", "");
});

pub const Version = struct {
    pub const major = c.LIBVLC_VERSION_MAJOR;
    pub const minor = c.LIBVLC_VERSION_MINOR;
    pub const revision = c.LIBVLC_VERSION_REVISION;
    pub const extra = c.LIBVLC_VERSION_EXTRA;
};

pub const Callback_t = c.libvlc_callback_t;
pub const Instance_t = c.libvlc_instance_t;
pub const Event_t = c.libvlc_event_t;
pub const Event_Type_t = c.libvlc_event_type_t;
pub const Event_Manage_t = c.libvlc_event_manager_t;
pub const Time_t = c.libvlc_time_t;
pub const Log_t = c.libvlc_log_t;
pub const MediaSlave_t = c.libvlc_media_slave_t;
pub const Media_t = c.libvlc_media_t;
pub const Media_player_t = c.libvlc_media_player_t;
pub const mediaOpen_callback = c.libvlc_media_open_cb;
pub const mediaSeek_callback = c.libvlc_media_seek_cb;
pub const mediaClose_callback = c.libvlc_media_close_cb;
pub const mediaRead_callback = c.libvlc_media_read_cb;
pub const VideoOutputCfg_t = c.libvlc_video_output_cfg_t;
pub const VideoRenderCfg_t = c.libvlc_video_render_cfg_t;
pub const VdeoSetupDeviceCfg_t = c.libvlc_video_setup_device_cfg_t;
pub const VideoSetupDeviceInfo_t = c.libvlc_video_setup_device_info_t;

pub const VideoColorSpace_t = enum(c_int) {
    BT601 = c.libvlc_video_colorspace_BT601,
    BT709 = c.libvlc_video_colorspace_BT709,
    BT2020 = c.libvlc_video_colorspace_BT2020,
};

const vlc_log = std.log.scoped(.vlc);

pub fn sleep(time: usize) void {
    std.os.nanosleep(time, time * std.time.ns_per_ms);
}
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
pub fn get_abiVersion() u32 {
    return switch (Version.major) {
        4 => @intCast(u32, c.libvlc_abi_version()),
        else => @panic("only VLC 4.x or higher"),
    };
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

// Media functions
pub fn media_new_location(p_instance: ?*Instance_t, psz_mrl: [*:0]const u8) ?*Media_t {
    return switch (Version.major) {
        4 => c.libvlc_media_new_location(@ptrCast([*c]const u8, psz_mrl)),
        else => c.libvlc_media_new_location(p_instance, @ptrCast([*c]const u8, psz_mrl)),
    };
}
pub fn media_new_path(p_instance: ?*Instance_t, path: [*:0]const u8) ?*Media_t {
    return switch (Version.major) {
        4 => c.libvlc_media_new_path(@ptrCast([*c]const u8, path)),
        else => c.libvlc_media_new_path(p_instance, @ptrCast([*c]const u8, path)),
    };
}
pub fn media_new_fd(p_instance: ?*Instance_t, fd: c_int) ?*Media_t {
    return c.libvlc_media_new_fd(p_instance, fd);
}
pub fn media_new_callbacks(p_instance: ?*Instance_t, open: mediaOpen_callback, read: mediaRead_callback, seek: mediaSeek_callback, close: mediaClose_callback, ptr: ?*anyopaque) ?*Media_t {
    return c.libvlc_media_new_callbacks(p_instance, open, read, seek, close, ptr);
}
pub fn media_new_as_node(p_instance: ?*Instance_t, psz_name: [*:0]const u8) ?*Media_t {
    return c.libvlc_media_new_as_node(p_instance, @ptrCast([*c]const u8, psz_name));
}
pub fn media_add_option(p_md: ?*Media_t, psz_options: [*:0]const u8) void {
    c.libvlc_media_add_option(p_md, @ptrCast([*c]const u8, psz_options));
}
pub fn media_release(p_instance: ?*Instance_t, p_md: ?*Media_t) void {
    _ = switch (Version.major) {
        4 => c.libvlc_media_release(p_instance, p_md),
        else => c.libvlc_media_release(p_md),
    };
}
// Media Player functions
pub fn media_player_new(p_instance: ?*Instance_t) ?*Media_player_t {
    return c.libvlc_media_player_new(p_instance);
}
pub fn media_player_new_from_media(p_instance: ?*Instance_t, p_md: ?*Media_t) ?*Media_player_t {
    return switch (Version.major) {
        4 => c.libvlc_media_player_new_from_media(p_instance, p_md),
        else => c.libvlc_media_player_new_from_media(p_md),
    };
}
pub fn media_player_is_playing(p_mi: ?*Media_player_t) c_int {
    return c.libvlc_media_player_is_playing(p_mi);
}
pub fn media_player_pause(p_mi: ?*Media_player_t) void {
    c.libvlc_media_player_pause(p_mi);
}
pub fn media_player_play(p_mi: ?*Media_player_t) c_int {
    return c.libvlc_media_player_play(p_mi);
}
pub fn media_player_stop(p_instance: ?*Instance_t, p_mi: ?*Media_player_t) void {
    _ = switch (Version.major) {
        4 => c.libvlc_media_player_stop(p_instance, p_mi),
        else => c.libvlc_media_player_stop(p_mi),
    };
}
pub fn media_player_release(p_mi: ?*Media_player_t) void {
    c.libvlc_media_player_release(p_mi);
}

// Enums
pub const MediaParsedStatus_t = enum(c_uint) {
    mediaParsedStatusSkipped = c.libvlc_media_parsed_status_skipped,
    mediaParsedStatusFailed = c.libvlc_media_parsed_status_failed,
    mediaParsedStatusTimeout = c.libvlc_media_parsed_status_timeout,
    mediaParsedStatusDone = c.libvlc_media_parsed_status_done,
};
pub const MediaSlaveType = enum(c_uint) {
    mediaSlaveTypeSubtitle = c.libvlc_media_slave_type_subtitle,
    mediaSlaveTypeAudio = c.libvlc_media_slave_type_audio,
};
pub const State_t = enum(c_int) {
    NothingSpecial = c.libvlc_NothingSpecial,
    Opening = c.libvlc_Opening,
    Buffering = c.libvlc_Buffering,
    Playing = c.libvlc_Playing,
    Paused = c.libvlc_Paused,
    Stopped = c.libvlc_Stopped,
    Ended = c.libvlc_Ended,
    Error = c.libvlc_Error,
};

pub const MediaParseFlag_t = enum(c_uint) {
    mediaParseLocal = c.libvlc_media_parse_local,
    mediaParseNetwork = c.libvlc_media_parse_network,
    mediaFetchLocal = c.libvlc_media_fetch_local,
    mediaFetchNetwork = c.libvlc_media_fetch_network,
    mediaDoInteract = c.libvlc_media_do_interact,
};

pub const Meta_t = enum(c_uint) {
    meta_Title = c.libvlc_meta_Title,
    meta_Artist = c.libvlc_meta_Artist,
    meta_Genre = c.libvlc_meta_Genre,
    meta_Copyright = c.libvlc_meta_Copyright,
    meta_Album = c.libvlc_meta_Album,
    meta_TrackNumber = c.libvlc_meta_TrackNumber,
    meta_Description = c.libvlc_meta_Description,
    meta_Rating = c.libvlc_meta_Rating,
    meta_Date = c.libvlc_meta_Date,
    meta_Setting = c.libvlc_meta_Setting,
    meta_URL = c.libvlc_meta_URL,
    meta_Language = c.libvlc_meta_Language,
    meta_NowPlaying = c.libvlc_meta_NowPlaying,
    meta_Publisher = c.libvlc_meta_Publisher,
    meta_EncodedBy = c.libvlc_meta_EncodedBy,
    meta_ArtworkURL = c.libvlc_meta_ArtworkURL,
    meta_TrackID = c.libvlc_meta_TrackID,
    meta_TrackTotal = c.libvlc_meta_TrackTotal,
    meta_Director = c.libvlc_meta_Director,
    meta_Season = c.libvlc_meta_Season,
    meta_Episode = c.libvlc_meta_Episode,
    meta_ShowName = c.libvlc_meta_ShowName,
    meta_Actors = c.libvlc_meta_Actors,
    meta_AlbumArtist = c.libvlc_meta_AlbumArtist,
    meta_DiscNumber = c.libvlc_meta_DiscNumber,
    meta_DiscTotal = c.libvlc_meta_DiscTotal,
};
