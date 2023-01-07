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
pub const MediaOpen_callback = c.libvlc_media_open_cb;
pub const MediaSeek_callback = c.libvlc_media_seek_cb;
pub const MediaClose_callback = c.libvlc_media_close_cb;
pub const MediaRead_callback = c.libvlc_media_read_cb;
pub const VideoOutputCleanup_callback = c.libvlc_video_output_cleanup_cb;
pub const VideoOutputSetup_callback = c.libvlc_video_output_setup_cb;
pub const VideoOutputSetResize_callback = c.libvlc_video_output_set_resize_cb;
pub const VideoUpdateOutput_callback = c.libvlc_video_update_output_cb;
pub const VideoSwap_callback = c.libvlc_video_swap_cb;
pub const VideoMakeCurrent_callback = c.libvlc_video_makeCurrent_cb;
pub const VideoGetProcAddr_callback = c.libvlc_video_getProcAddress_cb;
pub const VideoFrameMetadata_callback = c.libvlc_video_frameMetadata_cb;
pub const VideoOutputSelectPlane_callback = c.libvlc_video_output_select_plane_cb;
pub const VideoOutputCfg_t = c.libvlc_video_output_cfg_t;
pub const VideoRenderCfg_t = c.libvlc_video_render_cfg_t;
pub const VideoSetupDeviceCfg_t = c.libvlc_video_setup_device_cfg_t;
pub const VideoSetupDeviceInfo_t = c.libvlc_video_setup_device_info_t;
pub const VideoEngine_t = c.libvlc_video_engine_t;

pub const vlc_log = std.log.scoped(.vlc);

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
pub fn media_new_callbacks(p_instance: ?*Instance_t, open: MediaOpen_callback, read: MediaRead_callback, seek: MediaSeek_callback, close: MediaClose_callback, ptr: ?*anyopaque) ?*Media_t {
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
pub fn video_set_output_callbacks(mp: ?*Media_player_t, engine: VideoEngine_t, setup_cb: VideoOutputSetup_callback, cleanup_cb: VideoOutputCleanup_callback, resize_cb: VideoOutputSetResize_callback, update_output_cb: VideoUpdateOutput_callback, swap_cb: VideoSwap_callback, makeCurrent_cb: VideoMakeCurrent_callback, getProcAddress_cb: VideoGetProcAddr_callback, metadata_cb: VideoFrameMetadata_callback, select_plane_cb: VideoOutputSelectPlane_callback, ptr: ?*anyopaque) bool {
    return c.libvlc_video_set_output_callbacks(mp, engine, setup_cb, cleanup_cb, resize_cb, update_output_cb, swap_cb, makeCurrent_cb, getProcAddress_cb, metadata_cb, select_plane_cb, ptr);
}

// Enums
pub const VideoColorSpace_t = enum(c_int) {
    BT601 = c.libvlc_video_colorspace_BT601,
    BT709 = c.libvlc_video_colorspace_BT709,
    BT2020 = c.libvlc_video_colorspace_BT2020,
};

pub const VideoPrimaries_t = enum(c_int) {
    BT601_525 = c.libvlc_video_primaries_BT601_525,
    BT601_625 = c.libvlc_video_primaries_BT601_625,
    BT709 = c.libvlc_video_primaries_BT709,
    BT2020 = c.libvlc_video_primaries_BT2020,
    DCI_P3 = c.libvlc_video_primaries_DCI_P3,
    BT470_M = c.libvlc_video_primaries_BT470_M,
};

pub const VideoTransferFunc_t = enum(c_int) {
    LINEAR = c.libvlc_video_transfer_func_LINEAR,
    SRGB = c.libvlc_video_transfer_func_SRGB,
    BT470_BG = c.libvlc_video_transfer_func_BT470_BG,
    BT470_M = c.libvlc_video_transfer_func_BT470_M,
    BT709 = c.libvlc_video_transfer_func_BT709,
    PQ = c.libvlc_video_transfer_func_PQ,
    SMPTE_240 = c.libvlc_video_transfer_func_SMPTE_240,
    HLG = c.libvlc_video_transfer_func_HLG,
};

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
    Title = c.libvlc_meta_Title,
    Artist = c.libvlc_meta_Artist,
    Genre = c.libvlc_meta_Genre,
    Copyright = c.libvlc_meta_Copyright,
    Album = c.libvlc_meta_Album,
    TrackNumber = c.libvlc_meta_TrackNumber,
    Description = c.libvlc_meta_Description,
    Rating = c.libvlc_meta_Rating,
    Date = c.libvlc_meta_Date,
    Setting = c.libvlc_meta_Setting,
    URL = c.libvlc_meta_URL,
    Language = c.libvlc_meta_Language,
    NowPlaying = c.libvlc_meta_NowPlaying,
    Publisher = c.libvlc_meta_Publisher,
    EncodedBy = c.libvlc_meta_EncodedBy,
    ArtworkURL = c.libvlc_meta_ArtworkURL,
    TrackID = c.libvlc_meta_TrackID,
    TrackTotal = c.libvlc_meta_TrackTotal,
    Director = c.libvlc_meta_Director,
    Season = c.libvlc_meta_Season,
    Episode = c.libvlc_meta_Episode,
    ShowName = c.libvlc_meta_ShowName,
    Actors = c.libvlc_meta_Actors,
    AlbumArtist = c.libvlc_meta_AlbumArtist,
    DiscNumber = c.libvlc_meta_DiscNumber,
    DiscTotal = c.libvlc_meta_DiscTotal,
};

pub const VideoMarqueeOption_t = enum(c_int) {
    Enable = c.libvlc_marquee_Enable,
    Text = c.libvlc_marquee_Text,
    Color = c.libvlc_marquee_Color,
    Opacity = c.libvlc_marquee_Opacity,
    Position = c.libvlc_marquee_Position,
    Refresh = c.libvlc_marquee_Refresh,
    Size = c.libvlc_marquee_Size,
    Timeout = c.libvlc_marquee_Timeout,
    X = c.libvlc_marquee_X,
    Y = c.libvlc_marquee_Y,
};

pub const NavigateMode_t = enum(c_int) {
    activate = c.libvlc_navigate_activate,
    up = c.libvlc_navigate_up,
    down = c.libvlc_navigate_down,
    left = c.libvlc_navigate_left,
    right = c.libvlc_navigate_right,
    popup = c.libvlc_navigate_popup,
};

pub const Position_t = enum(c_int) {
    disable = c.libvlc_position_disable,
    center = c.libvlc_position_center,
    left = c.libvlc_position_left,
    right = c.libvlc_position_right,
    top = c.libvlc_position_top,
    top_left = c.libvlc_position_top_left,
    top_right = c.libvlc_position_top_right,
    bottom = c.libvlc_position_bottom,
    bottom_left = c.libvlc_position_bottom_left,
    bottom_right = c.libvlc_position_bottom_right,
};

pub const TeletextKey_t = enum(c_int) {
    key_red = c.libvlc_teletext_key_red,
    key_green = c.libvlc_teletext_key_green,
    key_yellow = c.libvlc_teletext_key_yellow,
    key_blue = c.libvlc_teletext_key_blue,
    key_index = c.libvlc_teletext_key_index,
};

pub const VideoOrient_t = enum(c_int) {
    top_left = c.libvlc_video_orient_top_left,
    top_right = c.libvlc_video_orient_top_right,
    bottom_left = c.libvlc_video_orient_bottom_left,
    bottom_right = c.libvlc_video_orient_bottom_right,
    left_top = c.libvlc_video_orient_left_top,
    left_bottom = c.libvlc_video_orient_left_bottom,
    right_top = c.libvlc_video_orient_right_top,
    right_bottom = c.libvlc_video_orient_right_bottom,
};

pub const VideoProjection_t = enum(c_int) {
    rectangular = c.libvlc_video_projection_rectangular,
    equirectangular = c.libvlc_video_projection_equirectangular,
    cubemap_layout_standard = c.libvlc_video_projection_cubemap_layout_standard,
};

pub const VideoMultiview_t = enum(c_int) {
    @"2d" = c.libvlc_video_multiview_2d,
    stereo_sbs = c.libvlc_video_multiview_stereo_sbs,
    stereo_tb = c.libvlc_video_multiview_stereo_tb,
    stereo_row = c.libvlc_video_multiview_stereo_row,
    stereo_col = c.libvlc_video_multiview_stereo_col,
    stereo_frame = c.libvlc_video_multiview_stereo_frame,
    stereo_checkerboard = c.libvlc_video_multiview_stereo_checkerboard,
};
