pub const struct___va_list_tag = extern struct {
    gp_offset: c_uint,
    fp_offset: c_uint,
    overflow_arg_area: ?*anyopaque,
    reg_save_area: ?*anyopaque,
};
pub const __builtin_va_list = [1]struct___va_list_tag;
pub const va_list = __builtin_va_list;
pub const __gnuc_va_list = __builtin_va_list;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int,
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
const union_unnamed_1 = extern union {
    __wch: c_uint,
    __wchb: [4]u8,
};
pub const __mbstate_t = extern struct {
    __count: c_int,
    __value: union_unnamed_1,
};
pub const struct__G_fpos_t = extern struct {
    __pos: __off_t,
    __state: __mbstate_t,
};
pub const __fpos_t = struct__G_fpos_t;
pub const struct__G_fpos64_t = extern struct {
    __pos: __off64_t,
    __state: __mbstate_t,
};
pub const __fpos64_t = struct__G_fpos64_t;
pub const struct__IO_marker = opaque {};
pub const _IO_lock_t = anyopaque;
pub const struct__IO_codecvt = opaque {};
pub const struct__IO_wide_data = opaque {};
pub const struct__IO_FILE = extern struct {
    _flags: c_int,
    _IO_read_ptr: [*c]u8,
    _IO_read_end: [*c]u8,
    _IO_read_base: [*c]u8,
    _IO_write_base: [*c]u8,
    _IO_write_ptr: [*c]u8,
    _IO_write_end: [*c]u8,
    _IO_buf_base: [*c]u8,
    _IO_buf_end: [*c]u8,
    _IO_save_base: [*c]u8,
    _IO_backup_base: [*c]u8,
    _IO_save_end: [*c]u8,
    _markers: ?*struct__IO_marker,
    _chain: [*c]struct__IO_FILE,
    _fileno: c_int,
    _flags2: c_int,
    _old_offset: __off_t,
    _cur_column: c_ushort,
    _vtable_offset: i8,
    _shortbuf: [1]u8,
    _lock: ?*_IO_lock_t,
    _offset: __off64_t,
    _codecvt: ?*struct__IO_codecvt,
    _wide_data: ?*struct__IO_wide_data,
    _freeres_list: [*c]struct__IO_FILE,
    _freeres_buf: ?*anyopaque,
    __pad5: usize,
    _mode: c_int,
    _unused2: [20]u8,
};
pub const __FILE = struct__IO_FILE;
pub const FILE = struct__IO_FILE;
pub const off_t = __off_t;
pub const fpos_t = __fpos_t;
pub extern var stdin: [*c]FILE;
pub extern var stdout: [*c]FILE;
pub extern var stderr: [*c]FILE;
pub extern fn remove(__filename: [*c]const u8) c_int;
pub extern fn rename(__old: [*c]const u8, __new: [*c]const u8) c_int;
pub extern fn renameat(__oldfd: c_int, __old: [*c]const u8, __newfd: c_int, __new: [*c]const u8) c_int;
pub extern fn fclose(__stream: [*c]FILE) c_int;
pub extern fn tmpfile() [*c]FILE;
pub extern fn tmpnam([*c]u8) [*c]u8;
pub extern fn tmpnam_r(__s: [*c]u8) [*c]u8;
pub extern fn tempnam(__dir: [*c]const u8, __pfx: [*c]const u8) [*c]u8;
pub extern fn fflush(__stream: [*c]FILE) c_int;
pub extern fn fflush_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fopen(__filename: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn freopen(noalias __filename: [*c]const u8, noalias __modes: [*c]const u8, noalias __stream: [*c]FILE) [*c]FILE;
pub extern fn fdopen(__fd: c_int, __modes: [*c]const u8) [*c]FILE;
pub extern fn fmemopen(__s: ?*anyopaque, __len: usize, __modes: [*c]const u8) [*c]FILE;
pub extern fn open_memstream(__bufloc: [*c][*c]u8, __sizeloc: [*c]usize) [*c]FILE;
pub extern fn setbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8) void;
pub extern fn setvbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __modes: c_int, __n: usize) c_int;
pub extern fn setbuffer(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __size: usize) void;
pub extern fn setlinebuf(__stream: [*c]FILE) void;
pub extern fn fprintf(__stream: [*c]FILE, __format: [*c]const u8, ...) c_int;
pub extern fn printf(__format: [*c]const u8, ...) c_int;
pub extern fn sprintf(__s: [*c]u8, __format: [*c]const u8, ...) c_int;
pub extern fn vfprintf(__s: [*c]FILE, __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn vprintf(__format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn vsprintf(__s: [*c]u8, __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn snprintf(__s: [*c]u8, __maxlen: c_ulong, __format: [*c]const u8, ...) c_int;
pub extern fn vsnprintf(__s: [*c]u8, __maxlen: c_ulong, __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn vdprintf(__fd: c_int, noalias __fmt: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn dprintf(__fd: c_int, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn fscanf(noalias __stream: [*c]FILE, noalias __format: [*c]const u8, ...) c_int;
pub extern fn scanf(noalias __format: [*c]const u8, ...) c_int;
pub extern fn sscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, ...) c_int;
pub const _Float32 = f32;
pub const _Float64 = f64;
pub const _Float32x = f64;
pub const _Float64x = c_longdouble;
pub extern fn vfscanf(noalias __s: [*c]FILE, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn vscanf(noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn vsscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag) c_int;
pub extern fn fgetc(__stream: [*c]FILE) c_int;
pub extern fn getc(__stream: [*c]FILE) c_int;
pub extern fn getchar() c_int;
pub extern fn getc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn getchar_unlocked() c_int;
pub extern fn fgetc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fputc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar(__c: c_int) c_int;
pub extern fn fputc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar_unlocked(__c: c_int) c_int;
pub extern fn getw(__stream: [*c]FILE) c_int;
pub extern fn putw(__w: c_int, __stream: [*c]FILE) c_int;
pub extern fn fgets(noalias __s: [*c]u8, __n: c_int, noalias __stream: [*c]FILE) [*c]u8;
pub extern fn __getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getline(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn fputs(noalias __s: [*c]const u8, noalias __stream: [*c]FILE) c_int;
pub extern fn puts(__s: [*c]const u8) c_int;
pub extern fn ungetc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn fread(__ptr: ?*anyopaque, __size: c_ulong, __n: c_ulong, __stream: [*c]FILE) c_ulong;
pub extern fn fwrite(__ptr: ?*const anyopaque, __size: c_ulong, __n: c_ulong, __s: [*c]FILE) c_ulong;
pub extern fn fread_unlocked(noalias __ptr: ?*anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fwrite_unlocked(noalias __ptr: ?*const anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fseek(__stream: [*c]FILE, __off: c_long, __whence: c_int) c_int;
pub extern fn ftell(__stream: [*c]FILE) c_long;
pub extern fn rewind(__stream: [*c]FILE) void;
pub extern fn fseeko(__stream: [*c]FILE, __off: __off_t, __whence: c_int) c_int;
pub extern fn ftello(__stream: [*c]FILE) __off_t;
pub extern fn fgetpos(noalias __stream: [*c]FILE, noalias __pos: [*c]fpos_t) c_int;
pub extern fn fsetpos(__stream: [*c]FILE, __pos: [*c]const fpos_t) c_int;
pub extern fn clearerr(__stream: [*c]FILE) void;
pub extern fn feof(__stream: [*c]FILE) c_int;
pub extern fn ferror(__stream: [*c]FILE) c_int;
pub extern fn clearerr_unlocked(__stream: [*c]FILE) void;
pub extern fn feof_unlocked(__stream: [*c]FILE) c_int;
pub extern fn ferror_unlocked(__stream: [*c]FILE) c_int;
pub extern fn perror(__s: [*c]const u8) void;
pub extern fn fileno(__stream: [*c]FILE) c_int;
pub extern fn fileno_unlocked(__stream: [*c]FILE) c_int;
pub extern fn pclose(__stream: [*c]FILE) c_int;
pub extern fn popen(__command: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn ctermid(__s: [*c]u8) [*c]u8;
pub extern fn flockfile(__stream: [*c]FILE) void;
pub extern fn ftrylockfile(__stream: [*c]FILE) c_int;
pub extern fn funlockfile(__stream: [*c]FILE) void;
pub extern fn __uflow([*c]FILE) c_int;
pub extern fn __overflow([*c]FILE, c_int) c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const struct_libvlc_instance_t = opaque {};
pub const libvlc_instance_t = struct_libvlc_instance_t;
pub const libvlc_time_t = i64;
pub extern fn libvlc_errmsg() [*c]const u8;
pub extern fn libvlc_clearerr() void;
pub extern fn libvlc_vprinterr(fmt: [*c]const u8, ap: [*c]struct___va_list_tag) [*c]const u8;
pub extern fn libvlc_printerr(fmt: [*c]const u8, ...) [*c]const u8;
pub extern fn libvlc_new(argc: c_int, argv: [*c]const [*c]const u8) ?*libvlc_instance_t;
pub extern fn libvlc_release(p_instance: ?*libvlc_instance_t) void;
pub extern fn libvlc_retain(p_instance: ?*libvlc_instance_t) void;
pub extern fn libvlc_add_intf(p_instance: ?*libvlc_instance_t, name: [*c]const u8) c_int;
pub extern fn libvlc_set_exit_handler(p_instance: ?*libvlc_instance_t, cb: ?*const fn (?*anyopaque) callconv(.C) void, @"opaque": ?*anyopaque) void;
pub extern fn libvlc_set_user_agent(p_instance: ?*libvlc_instance_t, name: [*c]const u8, http: [*c]const u8) void;
pub extern fn libvlc_set_app_id(p_instance: ?*libvlc_instance_t, id: [*c]const u8, version: [*c]const u8, icon: [*c]const u8) void;
pub extern fn libvlc_get_version() [*c]const u8;
pub extern fn libvlc_get_compiler() [*c]const u8;
pub extern fn libvlc_get_changeset() [*c]const u8;
pub extern fn libvlc_free(ptr: ?*anyopaque) void;
pub const struct_libvlc_event_manager_t = opaque {};
pub const struct_a = opaque {};
pub const libvlc_event_manager_t = struct_libvlc_event_manager_t;
pub const libvlc_meta_Title: c_int = 0;
pub const libvlc_meta_Artist: c_int = 1;
pub const libvlc_meta_Genre: c_int = 2;
pub const libvlc_meta_Copyright: c_int = 3;
pub const libvlc_meta_Album: c_int = 4;
pub const libvlc_meta_TrackNumber: c_int = 5;
pub const libvlc_meta_Description: c_int = 6;
pub const libvlc_meta_Rating: c_int = 7;
pub const libvlc_meta_Date: c_int = 8;
pub const libvlc_meta_Setting: c_int = 9;
pub const libvlc_meta_URL: c_int = 10;
pub const libvlc_meta_Language: c_int = 11;
pub const libvlc_meta_NowPlaying: c_int = 12;
pub const libvlc_meta_Publisher: c_int = 13;
pub const libvlc_meta_EncodedBy: c_int = 14;
pub const libvlc_meta_ArtworkURL: c_int = 15;
pub const libvlc_meta_TrackID: c_int = 16;
pub const libvlc_meta_TrackTotal: c_int = 17;
pub const libvlc_meta_Director: c_int = 18;
pub const libvlc_meta_Season: c_int = 19;
pub const libvlc_meta_Episode: c_int = 20;
pub const libvlc_meta_ShowName: c_int = 21;
pub const libvlc_meta_Actors: c_int = 22;
pub const libvlc_meta_AlbumArtist: c_int = 23;
pub const libvlc_meta_DiscNumber: c_int = 24;
pub const libvlc_meta_DiscTotal: c_int = 25;
pub const enum_libvlc_meta_t = c_uint;
pub const libvlc_meta_t = enum_libvlc_meta_t;
const struct_unnamed_3 = extern struct {
    meta_type: libvlc_meta_t,
};
pub const struct_libvlc_media_t = opaque {};
pub const libvlc_media_t = struct_libvlc_media_t;
const struct_unnamed_4 = extern struct {
    new_child: ?*libvlc_media_t,
};
const struct_unnamed_5 = extern struct {
    new_duration: i64,
};
const struct_unnamed_6 = extern struct {
    new_status: c_int,
};
const struct_unnamed_7 = extern struct {
    md: ?*libvlc_media_t,
};
const struct_unnamed_8 = extern struct {
    new_state: c_int,
};
const struct_unnamed_9 = extern struct {
    item: ?*libvlc_media_t,
};
const struct_unnamed_10 = extern struct {
    new_cache: f32,
};
const struct_unnamed_11 = extern struct {
    new_chapter: c_int,
};
const struct_unnamed_12 = extern struct {
    new_position: f32,
};
const struct_unnamed_13 = extern struct {
    new_time: libvlc_time_t,
};
const struct_unnamed_14 = extern struct {
    new_title: c_int,
};
const struct_unnamed_15 = extern struct {
    new_seekable: c_int,
};
const struct_unnamed_16 = extern struct {
    new_pausable: c_int,
};
const struct_unnamed_17 = extern struct {
    new_scrambled: c_int,
};
const struct_unnamed_18 = extern struct {
    new_count: c_int,
};
const struct_unnamed_19 = extern struct {
    item: ?*libvlc_media_t,
    index: c_int,
};
const struct_unnamed_20 = extern struct {
    item: ?*libvlc_media_t,
    index: c_int,
};
const struct_unnamed_21 = extern struct {
    item: ?*libvlc_media_t,
    index: c_int,
};
const struct_unnamed_22 = extern struct {
    item: ?*libvlc_media_t,
    index: c_int,
};
const struct_unnamed_23 = extern struct {
    item: ?*libvlc_media_t,
};
const struct_unnamed_24 = extern struct {
    psz_filename: [*c]u8,
};
const struct_unnamed_25 = extern struct {
    new_length: libvlc_time_t,
};
const struct_unnamed_26 = extern struct {
    psz_media_name: [*c]const u8,
    psz_instance_name: [*c]const u8,
};
const struct_unnamed_27 = extern struct {
    new_media: ?*libvlc_media_t,
};
pub const libvlc_track_unknown: c_int = -1;
pub const libvlc_track_audio: c_int = 0;
pub const libvlc_track_video: c_int = 1;
pub const libvlc_track_text: c_int = 2;
pub const enum_libvlc_track_type_t = c_int;
pub const libvlc_track_type_t = enum_libvlc_track_type_t;
const struct_unnamed_28 = extern struct {
    i_type: libvlc_track_type_t,
    i_id: c_int,
};
const struct_unnamed_29 = extern struct {
    volume: f32,
};
const struct_unnamed_30 = extern struct {
    device: [*c]const u8,
};
pub const struct_libvlc_renderer_item_t = opaque {};
pub const libvlc_renderer_item_t = struct_libvlc_renderer_item_t;
const struct_unnamed_31 = extern struct {
    item: ?*libvlc_renderer_item_t,
};
const struct_unnamed_32 = extern struct {
    item: ?*libvlc_renderer_item_t,
};
const union_unnamed_2 = extern union {
    media_meta_changed: struct_unnamed_3,
    media_subitem_added: struct_unnamed_4,
    media_duration_changed: struct_unnamed_5,
    media_parsed_changed: struct_unnamed_6,
    media_freed: struct_unnamed_7,
    media_state_changed: struct_unnamed_8,
    media_subitemtree_added: struct_unnamed_9,
    media_player_buffering: struct_unnamed_10,
    media_player_chapter_changed: struct_unnamed_11,
    media_player_position_changed: struct_unnamed_12,
    media_player_time_changed: struct_unnamed_13,
    media_player_title_changed: struct_unnamed_14,
    media_player_seekable_changed: struct_unnamed_15,
    media_player_pausable_changed: struct_unnamed_16,
    media_player_scrambled_changed: struct_unnamed_17,
    media_player_vout: struct_unnamed_18,
    media_list_item_added: struct_unnamed_19,
    media_list_will_add_item: struct_unnamed_20,
    media_list_item_deleted: struct_unnamed_21,
    media_list_will_delete_item: struct_unnamed_22,
    media_list_player_next_item_set: struct_unnamed_23,
    media_player_snapshot_taken: struct_unnamed_24,
    media_player_length_changed: struct_unnamed_25,
    vlm_media_event: struct_unnamed_26,
    media_player_media_changed: struct_unnamed_27,
    media_player_es_changed: struct_unnamed_28,
    media_player_audio_volume: struct_unnamed_29,
    media_player_audio_device: struct_unnamed_30,
    renderer_discoverer_item_added: struct_unnamed_31,
    renderer_discoverer_item_deleted: struct_unnamed_32,
};
pub const struct_libvlc_event_t = extern struct {
    type: c_int,
    p_obj: ?*anyopaque,
    u: union_unnamed_2,
};
pub const libvlc_event_type_t = c_int;
pub const libvlc_callback_t = ?*const fn ([*c]const struct_libvlc_event_t, ?*anyopaque) callconv(.C) void;
pub extern fn libvlc_event_attach(p_event_manager: ?*libvlc_event_manager_t, i_event_type: libvlc_event_type_t, f_callback: libvlc_callback_t, user_data: ?*anyopaque) c_int;
pub extern fn libvlc_event_detach(p_event_manager: ?*libvlc_event_manager_t, i_event_type: libvlc_event_type_t, f_callback: libvlc_callback_t, p_user_data: ?*anyopaque) void;
pub extern fn libvlc_event_type_name(event_type: libvlc_event_type_t) [*c]const u8;
pub const LIBVLC_DEBUG: c_int = 0;
pub const LIBVLC_NOTICE: c_int = 2;
pub const LIBVLC_WARNING: c_int = 3;
pub const LIBVLC_ERROR: c_int = 4;
pub const enum_libvlc_log_level = c_uint;
pub const struct_vlc_log_t = opaque {};
pub const libvlc_log_t = struct_vlc_log_t;
pub extern fn libvlc_log_get_context(ctx: ?*const libvlc_log_t, module: [*c][*c]const u8, file: [*c][*c]const u8, line: [*c]c_uint) void;
pub extern fn libvlc_log_get_object(ctx: ?*const libvlc_log_t, name: [*c][*c]const u8, header: [*c][*c]const u8, id: [*c]usize) void;
pub const libvlc_log_cb = ?*const fn (?*anyopaque, c_int, ?*const libvlc_log_t, [*c]const u8, [*c]struct___va_list_tag) callconv(.C) void;
pub extern fn libvlc_log_unset(p_instance: ?*libvlc_instance_t) void;
pub extern fn libvlc_log_set(p_instance: ?*libvlc_instance_t, cb: libvlc_log_cb, data: ?*anyopaque) void;
pub extern fn libvlc_log_set_file(p_instance: ?*libvlc_instance_t, stream: [*c]FILE) void;
pub const struct_libvlc_module_description_t = extern struct {
    psz_name: [*c]u8,
    psz_shortname: [*c]u8,
    psz_longname: [*c]u8,
    psz_help: [*c]u8,
    p_next: [*c]struct_libvlc_module_description_t,
};
pub const libvlc_module_description_t = struct_libvlc_module_description_t;
pub extern fn libvlc_module_description_list_release(p_list: [*c]libvlc_module_description_t) void;
pub extern fn libvlc_audio_filter_list_get(p_instance: ?*libvlc_instance_t) [*c]libvlc_module_description_t;
pub extern fn libvlc_video_filter_list_get(p_instance: ?*libvlc_instance_t) [*c]libvlc_module_description_t;
pub extern fn libvlc_clock() i64;
pub fn libvlc_delay(arg_pts: i64) callconv(.C) i64 {
    var pts = arg_pts;
    return pts - libvlc_clock();
}
pub const struct_libvlc_renderer_discoverer_t = opaque {};
pub const libvlc_renderer_discoverer_t = struct_libvlc_renderer_discoverer_t;
pub const struct_libvlc_rd_description_t = extern struct {
    psz_name: [*c]u8,
    psz_longname: [*c]u8,
};
pub const libvlc_rd_description_t = struct_libvlc_rd_description_t;
pub extern fn libvlc_renderer_item_hold(p_item: ?*libvlc_renderer_item_t) ?*libvlc_renderer_item_t;
pub extern fn libvlc_renderer_item_release(p_item: ?*libvlc_renderer_item_t) void;
pub extern fn libvlc_renderer_item_name(p_item: ?*const libvlc_renderer_item_t) [*c]const u8;
pub extern fn libvlc_renderer_item_type(p_item: ?*const libvlc_renderer_item_t) [*c]const u8;
pub extern fn libvlc_renderer_item_icon_uri(p_item: ?*const libvlc_renderer_item_t) [*c]const u8;
pub extern fn libvlc_renderer_item_flags(p_item: ?*const libvlc_renderer_item_t) c_int;
pub extern fn libvlc_renderer_discoverer_new(p_inst: ?*libvlc_instance_t, psz_name: [*c]const u8) ?*libvlc_renderer_discoverer_t;
pub extern fn libvlc_renderer_discoverer_release(p_rd: ?*libvlc_renderer_discoverer_t) void;
pub extern fn libvlc_renderer_discoverer_start(p_rd: ?*libvlc_renderer_discoverer_t) c_int;
pub extern fn libvlc_renderer_discoverer_stop(p_rd: ?*libvlc_renderer_discoverer_t) void;
pub extern fn libvlc_renderer_discoverer_event_manager(p_rd: ?*libvlc_renderer_discoverer_t) ?*libvlc_event_manager_t;
pub extern fn libvlc_renderer_discoverer_list_get(p_inst: ?*libvlc_instance_t, ppp_services: [*c][*c][*c]libvlc_rd_description_t) usize;
pub extern fn libvlc_renderer_discoverer_list_release(pp_services: [*c][*c]libvlc_rd_description_t, i_count: usize) void;
pub const libvlc_NothingSpecial: c_int = 0;
pub const libvlc_Opening: c_int = 1;
pub const libvlc_Buffering: c_int = 2;
pub const libvlc_Playing: c_int = 3;
pub const libvlc_Paused: c_int = 4;
pub const libvlc_Stopped: c_int = 5;
pub const libvlc_Ended: c_int = 6;
pub const libvlc_Error: c_int = 7;
pub const enum_libvlc_state_t = c_uint;
pub const libvlc_state_t = enum_libvlc_state_t;
pub const libvlc_media_option_trusted: c_int = 2;
pub const libvlc_media_option_unique: c_int = 256;
const enum_unnamed_33 = c_uint;
pub const struct_libvlc_media_stats_t = extern struct {
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
pub const libvlc_media_stats_t = struct_libvlc_media_stats_t;
const struct_unnamed_35 = extern struct {
    i_channels: c_uint,
    i_rate: c_uint,
};
const struct_unnamed_36 = extern struct {
    i_height: c_uint,
    i_width: c_uint,
};
const union_unnamed_34 = extern union {
    audio: struct_unnamed_35,
    video: struct_unnamed_36,
};
pub const struct_libvlc_media_track_info_t = extern struct {
    i_codec: u32,
    i_id: c_int,
    i_type: libvlc_track_type_t,
    i_profile: c_int,
    i_level: c_int,
    u: union_unnamed_34,
};
pub const libvlc_media_track_info_t = struct_libvlc_media_track_info_t;
pub const struct_libvlc_audio_track_t = extern struct {
    i_channels: c_uint,
    i_rate: c_uint,
};
pub const libvlc_audio_track_t = struct_libvlc_audio_track_t;
pub const libvlc_video_orient_top_left: c_int = 0;
pub const libvlc_video_orient_top_right: c_int = 1;
pub const libvlc_video_orient_bottom_left: c_int = 2;
pub const libvlc_video_orient_bottom_right: c_int = 3;
pub const libvlc_video_orient_left_top: c_int = 4;
pub const libvlc_video_orient_left_bottom: c_int = 5;
pub const libvlc_video_orient_right_top: c_int = 6;
pub const libvlc_video_orient_right_bottom: c_int = 7;
pub const enum_libvlc_video_orient_t = c_uint;
pub const libvlc_video_orient_t = enum_libvlc_video_orient_t;
pub const libvlc_video_projection_rectangular: c_int = 0;
pub const libvlc_video_projection_equirectangular: c_int = 1;
pub const libvlc_video_projection_cubemap_layout_standard: c_int = 256;
pub const enum_libvlc_video_projection_t = c_uint;
pub const libvlc_video_projection_t = enum_libvlc_video_projection_t;
pub const struct_libvlc_video_viewpoint_t = extern struct {
    f_yaw: f32,
    f_pitch: f32,
    f_roll: f32,
    f_field_of_view: f32,
};
pub const libvlc_video_viewpoint_t = struct_libvlc_video_viewpoint_t;
pub const struct_libvlc_video_track_t = extern struct {
    i_height: c_uint,
    i_width: c_uint,
    i_sar_num: c_uint,
    i_sar_den: c_uint,
    i_frame_rate_num: c_uint,
    i_frame_rate_den: c_uint,
    i_orientation: libvlc_video_orient_t,
    i_projection: libvlc_video_projection_t,
    pose: libvlc_video_viewpoint_t,
};
pub const libvlc_video_track_t = struct_libvlc_video_track_t;
pub const struct_libvlc_subtitle_track_t = extern struct {
    psz_encoding: [*c]u8,
};
pub const libvlc_subtitle_track_t = struct_libvlc_subtitle_track_t;
const union_unnamed_37 = extern union {
    audio: [*c]libvlc_audio_track_t,
    video: [*c]libvlc_video_track_t,
    subtitle: [*c]libvlc_subtitle_track_t,
};
pub const struct_libvlc_media_track_t = extern struct {
    i_codec: u32,
    i_original_fourcc: u32,
    i_id: c_int,
    i_type: libvlc_track_type_t,
    i_profile: c_int,
    i_level: c_int,
    unnamed_0: union_unnamed_37,
    i_bitrate: c_uint,
    psz_language: [*c]u8,
    psz_description: [*c]u8,
};
pub const libvlc_media_track_t = struct_libvlc_media_track_t;
pub const libvlc_media_type_unknown: c_int = 0;
pub const libvlc_media_type_file: c_int = 1;
pub const libvlc_media_type_directory: c_int = 2;
pub const libvlc_media_type_disc: c_int = 3;
pub const libvlc_media_type_stream: c_int = 4;
pub const libvlc_media_type_playlist: c_int = 5;
pub const enum_libvlc_media_type_t = c_uint;
pub const libvlc_media_type_t = enum_libvlc_media_type_t;
pub const libvlc_media_parse_local: c_int = 0;
pub const libvlc_media_parse_network: c_int = 1;
pub const libvlc_media_fetch_local: c_int = 2;
pub const libvlc_media_fetch_network: c_int = 4;
pub const libvlc_media_do_interact: c_int = 8;
pub const enum_libvlc_media_parse_flag_t = c_uint;
pub const libvlc_media_parse_flag_t = enum_libvlc_media_parse_flag_t;
pub const libvlc_media_parsed_status_skipped: c_int = 1;
pub const libvlc_media_parsed_status_failed: c_int = 2;
pub const libvlc_media_parsed_status_timeout: c_int = 3;
pub const libvlc_media_parsed_status_done: c_int = 4;
pub const enum_libvlc_media_parsed_status_t = c_uint;
pub const libvlc_media_parsed_status_t = enum_libvlc_media_parsed_status_t;
pub const libvlc_media_slave_type_subtitle: c_int = 0;
pub const libvlc_media_slave_type_audio: c_int = 1;
pub const enum_libvlc_media_slave_type_t = c_uint;
pub const libvlc_media_slave_type_t = enum_libvlc_media_slave_type_t;
pub const struct_libvlc_media_slave_t = extern struct {
    psz_uri: [*c]u8,
    i_type: libvlc_media_slave_type_t,
    i_priority: c_uint,
};
pub const libvlc_media_slave_t = struct_libvlc_media_slave_t;
pub const libvlc_media_open_cb = ?*const fn (?*anyopaque, [*c]?*anyopaque, [*c]u64) callconv(.C) c_int;
pub const libvlc_media_read_cb = ?*const fn (?*anyopaque, [*c]u8, usize) callconv(.C) isize;
pub const libvlc_media_seek_cb = ?*const fn (?*anyopaque, u64) callconv(.C) c_int;
pub const libvlc_media_close_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn libvlc_media_new_location(p_instance: ?*libvlc_instance_t, psz_mrl: [*c]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_new_path(p_instance: ?*libvlc_instance_t, path: [*c]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_new_fd(p_instance: ?*libvlc_instance_t, fd: c_int) ?*libvlc_media_t;
pub extern fn libvlc_media_new_callbacks(instance: ?*libvlc_instance_t, open_cb: libvlc_media_open_cb, read_cb: libvlc_media_read_cb, seek_cb: libvlc_media_seek_cb, close_cb: libvlc_media_close_cb, @"opaque": ?*anyopaque) ?*libvlc_media_t;
pub extern fn libvlc_media_new_as_node(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) ?*libvlc_media_t;
pub extern fn libvlc_media_add_option(p_md: ?*libvlc_media_t, psz_options: [*c]const u8) void;
pub extern fn libvlc_media_add_option_flag(p_md: ?*libvlc_media_t, psz_options: [*c]const u8, i_flags: c_uint) void;
pub extern fn libvlc_media_retain(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_release(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_get_mrl(p_md: ?*libvlc_media_t) [*c]u8;
pub extern fn libvlc_media_duplicate(p_md: ?*libvlc_media_t) ?*libvlc_media_t;
pub extern fn libvlc_media_get_meta(p_md: ?*libvlc_media_t, e_meta: libvlc_meta_t) [*c]u8;
pub extern fn libvlc_media_set_meta(p_md: ?*libvlc_media_t, e_meta: libvlc_meta_t, psz_value: [*c]const u8) void;
pub extern fn libvlc_media_save_meta(p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_get_state(p_md: ?*libvlc_media_t) libvlc_state_t;
pub extern fn libvlc_media_get_stats(p_md: ?*libvlc_media_t, p_stats: [*c]libvlc_media_stats_t) c_int;
pub const struct_libvlc_media_list_t = opaque {};
pub extern fn libvlc_media_subitems(p_md: ?*libvlc_media_t) ?*struct_libvlc_media_list_t;
pub extern fn libvlc_media_event_manager(p_md: ?*libvlc_media_t) ?*libvlc_event_manager_t;
pub extern fn libvlc_media_get_duration(p_md: ?*libvlc_media_t) libvlc_time_t;
pub extern fn libvlc_media_parse_with_options(p_md: ?*libvlc_media_t, parse_flag: libvlc_media_parse_flag_t, timeout: c_int) c_int;
pub extern fn libvlc_media_parse_stop(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_get_parsed_status(p_md: ?*libvlc_media_t) libvlc_media_parsed_status_t;
pub extern fn libvlc_media_set_user_data(p_md: ?*libvlc_media_t, p_new_user_data: ?*anyopaque) void;
pub extern fn libvlc_media_get_user_data(p_md: ?*libvlc_media_t) ?*anyopaque;
pub extern fn libvlc_media_tracks_get(p_md: ?*libvlc_media_t, tracks: [*c][*c][*c]libvlc_media_track_t) c_uint;
pub extern fn libvlc_media_get_codec_description(i_type: libvlc_track_type_t, i_codec: u32) [*c]const u8;
pub extern fn libvlc_media_tracks_release(p_tracks: [*c][*c]libvlc_media_track_t, i_count: c_uint) void;
pub extern fn libvlc_media_get_type(p_md: ?*libvlc_media_t) libvlc_media_type_t;
pub extern fn libvlc_media_slaves_add(p_md: ?*libvlc_media_t, i_type: libvlc_media_slave_type_t, i_priority: c_uint, psz_uri: [*c]const u8) c_int;
pub extern fn libvlc_media_slaves_clear(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_slaves_get(p_md: ?*libvlc_media_t, ppp_slaves: [*c][*c][*c]libvlc_media_slave_t) c_uint;
pub extern fn libvlc_media_slaves_release(pp_slaves: [*c][*c]libvlc_media_slave_t, i_count: c_uint) void;
pub const struct_libvlc_media_player_t = opaque {};
pub const libvlc_media_player_t = struct_libvlc_media_player_t;
pub const struct_libvlc_track_description_t = extern struct {
    i_id: c_int,
    psz_name: [*c]u8,
    p_next: [*c]struct_libvlc_track_description_t,
};
pub const libvlc_track_description_t = struct_libvlc_track_description_t;
pub const libvlc_title_menu: c_int = 1;
pub const libvlc_title_interactive: c_int = 2;
const enum_unnamed_38 = c_uint;
pub const struct_libvlc_title_description_t = extern struct {
    i_duration: i64,
    psz_name: [*c]u8,
    i_flags: c_uint,
};
pub const libvlc_title_description_t = struct_libvlc_title_description_t;
pub const struct_libvlc_chapter_description_t = extern struct {
    i_time_offset: i64,
    i_duration: i64,
    psz_name: [*c]u8,
};
pub const libvlc_chapter_description_t = struct_libvlc_chapter_description_t;
pub const struct_libvlc_audio_output_t = extern struct {
    psz_name: [*c]u8,
    psz_description: [*c]u8,
    p_next: [*c]struct_libvlc_audio_output_t,
};
pub const libvlc_audio_output_t = struct_libvlc_audio_output_t;
pub const struct_libvlc_audio_output_device_t = extern struct {
    p_next: [*c]struct_libvlc_audio_output_device_t,
    psz_device: [*c]u8,
    psz_description: [*c]u8,
};
pub const libvlc_audio_output_device_t = struct_libvlc_audio_output_device_t;
pub const libvlc_marquee_Enable: c_int = 0;
pub const libvlc_marquee_Text: c_int = 1;
pub const libvlc_marquee_Color: c_int = 2;
pub const libvlc_marquee_Opacity: c_int = 3;
pub const libvlc_marquee_Position: c_int = 4;
pub const libvlc_marquee_Refresh: c_int = 5;
pub const libvlc_marquee_Size: c_int = 6;
pub const libvlc_marquee_Timeout: c_int = 7;
pub const libvlc_marquee_X: c_int = 8;
pub const libvlc_marquee_Y: c_int = 9;
pub const enum_libvlc_video_marquee_option_t = c_uint;
pub const libvlc_video_marquee_option_t = enum_libvlc_video_marquee_option_t;
pub const libvlc_navigate_activate: c_int = 0;
pub const libvlc_navigate_up: c_int = 1;
pub const libvlc_navigate_down: c_int = 2;
pub const libvlc_navigate_left: c_int = 3;
pub const libvlc_navigate_right: c_int = 4;
pub const libvlc_navigate_popup: c_int = 5;
pub const enum_libvlc_navigate_mode_t = c_uint;
pub const libvlc_navigate_mode_t = enum_libvlc_navigate_mode_t;
pub const libvlc_position_disable: c_int = -1;
pub const libvlc_position_center: c_int = 0;
pub const libvlc_position_left: c_int = 1;
pub const libvlc_position_right: c_int = 2;
pub const libvlc_position_top: c_int = 3;
pub const libvlc_position_top_left: c_int = 4;
pub const libvlc_position_top_right: c_int = 5;
pub const libvlc_position_bottom: c_int = 6;
pub const libvlc_position_bottom_left: c_int = 7;
pub const libvlc_position_bottom_right: c_int = 8;
pub const enum_libvlc_position_t = c_int;
pub const libvlc_position_t = enum_libvlc_position_t;
pub const libvlc_teletext_key_red: c_int = 7471104;
pub const libvlc_teletext_key_green: c_int = 6750208;
pub const libvlc_teletext_key_yellow: c_int = 7929856;
pub const libvlc_teletext_key_blue: c_int = 6422528;
pub const libvlc_teletext_key_index: c_int = 6881280;
pub const enum_libvlc_teletext_key_t = c_uint;
pub const libvlc_teletext_key_t = enum_libvlc_teletext_key_t;
pub const struct_libvlc_equalizer_t = opaque {};
pub const libvlc_equalizer_t = struct_libvlc_equalizer_t;
pub extern fn libvlc_media_player_new(p_libvlc_instance: ?*libvlc_instance_t) ?*libvlc_media_player_t;
pub extern fn libvlc_media_player_new_from_media(p_md: ?*libvlc_media_t) ?*libvlc_media_player_t;
pub extern fn libvlc_media_player_release(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_retain(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_set_media(p_mi: ?*libvlc_media_player_t, p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_player_get_media(p_mi: ?*libvlc_media_player_t) ?*libvlc_media_t;
pub extern fn libvlc_media_player_event_manager(p_mi: ?*libvlc_media_player_t) ?*libvlc_event_manager_t;
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
pub extern fn libvlc_video_set_format(mp: ?*libvlc_media_player_t, chroma: [*c]const u8, width: c_uint, height: c_uint, pitch: c_uint) void;
pub extern fn libvlc_video_set_format_callbacks(mp: ?*libvlc_media_player_t, setup: libvlc_video_format_cb, cleanup: libvlc_video_cleanup_cb) void;
pub extern fn libvlc_media_player_set_nsobject(p_mi: ?*libvlc_media_player_t, drawable: ?*anyopaque) void;
pub extern fn libvlc_media_player_get_nsobject(p_mi: ?*libvlc_media_player_t) ?*anyopaque;
pub extern fn libvlc_media_player_set_xwindow(p_mi: ?*libvlc_media_player_t, drawable: u32) void;
pub extern fn libvlc_media_player_get_xwindow(p_mi: ?*libvlc_media_player_t) u32;
pub extern fn libvlc_media_player_set_hwnd(p_mi: ?*libvlc_media_player_t, drawable: ?*anyopaque) void;
pub extern fn libvlc_media_player_get_hwnd(p_mi: ?*libvlc_media_player_t) ?*anyopaque;
pub extern fn libvlc_media_player_set_android_context(p_mi: ?*libvlc_media_player_t, p_awindow_handler: ?*anyopaque) void;
pub extern fn libvlc_media_player_set_evas_object(p_mi: ?*libvlc_media_player_t, p_evas_object: ?*anyopaque) c_int;
pub const libvlc_audio_play_cb = ?*const fn (?*anyopaque, ?*const anyopaque, c_uint, i64) callconv(.C) void;
pub const libvlc_audio_pause_cb = ?*const fn (?*anyopaque, i64) callconv(.C) void;
pub const libvlc_audio_resume_cb = ?*const fn (?*anyopaque, i64) callconv(.C) void;
pub const libvlc_audio_flush_cb = ?*const fn (?*anyopaque, i64) callconv(.C) void;
pub const libvlc_audio_drain_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub const libvlc_audio_set_volume_cb = ?*const fn (?*anyopaque, f32, bool) callconv(.C) void;
pub extern fn libvlc_audio_set_callbacks(mp: ?*libvlc_media_player_t, play: libvlc_audio_play_cb, pause: libvlc_audio_pause_cb, @"resume": libvlc_audio_resume_cb, flush: libvlc_audio_flush_cb, drain: libvlc_audio_drain_cb, @"opaque": ?*anyopaque) void;
pub extern fn libvlc_audio_set_volume_callback(mp: ?*libvlc_media_player_t, set_volume: libvlc_audio_set_volume_cb) void;
pub const libvlc_audio_setup_cb = ?*const fn ([*c]?*anyopaque, [*c]u8, [*c]c_uint, [*c]c_uint) callconv(.C) c_int;
pub const libvlc_audio_cleanup_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn libvlc_audio_set_format_callbacks(mp: ?*libvlc_media_player_t, setup: libvlc_audio_setup_cb, cleanup: libvlc_audio_cleanup_cb) void;
pub extern fn libvlc_audio_set_format(mp: ?*libvlc_media_player_t, format: [*c]const u8, rate: c_uint, channels: c_uint) void;
pub extern fn libvlc_media_player_get_length(p_mi: ?*libvlc_media_player_t) libvlc_time_t;
pub extern fn libvlc_media_player_get_time(p_mi: ?*libvlc_media_player_t) libvlc_time_t;
pub extern fn libvlc_media_player_set_time(p_mi: ?*libvlc_media_player_t, i_time: libvlc_time_t) void;
pub extern fn libvlc_media_player_get_position(p_mi: ?*libvlc_media_player_t) f32;
pub extern fn libvlc_media_player_set_position(p_mi: ?*libvlc_media_player_t, f_pos: f32) void;
pub extern fn libvlc_media_player_set_chapter(p_mi: ?*libvlc_media_player_t, i_chapter: c_int) void;
pub extern fn libvlc_media_player_get_chapter(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_get_chapter_count(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_will_play(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_get_chapter_count_for_title(p_mi: ?*libvlc_media_player_t, i_title: c_int) c_int;
pub extern fn libvlc_media_player_set_title(p_mi: ?*libvlc_media_player_t, i_title: c_int) void;
pub extern fn libvlc_media_player_get_title(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_get_title_count(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_previous_chapter(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_next_chapter(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_get_rate(p_mi: ?*libvlc_media_player_t) f32;
pub extern fn libvlc_media_player_set_rate(p_mi: ?*libvlc_media_player_t, rate: f32) c_int;
pub extern fn libvlc_media_player_get_state(p_mi: ?*libvlc_media_player_t) libvlc_state_t;
pub extern fn libvlc_media_player_has_vout(p_mi: ?*libvlc_media_player_t) c_uint;
pub extern fn libvlc_media_player_is_seekable(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_can_pause(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_program_scrambled(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_next_frame(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_player_navigate(p_mi: ?*libvlc_media_player_t, navigate: c_uint) void;
pub extern fn libvlc_media_player_set_video_title_display(p_mi: ?*libvlc_media_player_t, position: libvlc_position_t, timeout: c_uint) void;
pub extern fn libvlc_media_player_add_slave(p_mi: ?*libvlc_media_player_t, i_type: libvlc_media_slave_type_t, psz_uri: [*c]const u8, b_select: bool) c_int;
pub extern fn libvlc_track_description_list_release(p_track_description: [*c]libvlc_track_description_t) void;
pub extern fn libvlc_toggle_fullscreen(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_set_fullscreen(p_mi: ?*libvlc_media_player_t, b_fullscreen: c_int) void;
pub extern fn libvlc_get_fullscreen(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_set_key_input(p_mi: ?*libvlc_media_player_t, on: c_uint) void;
pub extern fn libvlc_video_set_mouse_input(p_mi: ?*libvlc_media_player_t, on: c_uint) void;
pub extern fn libvlc_video_get_size(p_mi: ?*libvlc_media_player_t, num: c_uint, px: [*c]c_uint, py: [*c]c_uint) c_int;
pub extern fn libvlc_video_get_cursor(p_mi: ?*libvlc_media_player_t, num: c_uint, px: [*c]c_int, py: [*c]c_int) c_int;
pub extern fn libvlc_video_get_scale(p_mi: ?*libvlc_media_player_t) f32;
pub extern fn libvlc_video_set_scale(p_mi: ?*libvlc_media_player_t, f_factor: f32) void;
pub extern fn libvlc_video_get_aspect_ratio(p_mi: ?*libvlc_media_player_t) [*c]u8;
pub extern fn libvlc_video_set_aspect_ratio(p_mi: ?*libvlc_media_player_t, psz_aspect: [*c]const u8) void;
pub extern fn libvlc_video_new_viewpoint() [*c]libvlc_video_viewpoint_t;
pub extern fn libvlc_video_update_viewpoint(p_mi: ?*libvlc_media_player_t, p_viewpoint: [*c]const libvlc_video_viewpoint_t, b_absolute: bool) c_int;
pub extern fn libvlc_video_get_spu(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_get_spu_count(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_get_spu_description(p_mi: ?*libvlc_media_player_t) [*c]libvlc_track_description_t;
pub extern fn libvlc_video_set_spu(p_mi: ?*libvlc_media_player_t, i_spu: c_int) c_int;
pub extern fn libvlc_video_get_spu_delay(p_mi: ?*libvlc_media_player_t) i64;
pub extern fn libvlc_video_set_spu_delay(p_mi: ?*libvlc_media_player_t, i_delay: i64) c_int;
pub extern fn libvlc_media_player_get_full_title_descriptions(p_mi: ?*libvlc_media_player_t, titles: [*c][*c][*c]libvlc_title_description_t) c_int;
pub extern fn libvlc_title_descriptions_release(p_titles: [*c][*c]libvlc_title_description_t, i_count: c_uint) void;
pub extern fn libvlc_media_player_get_full_chapter_descriptions(p_mi: ?*libvlc_media_player_t, i_chapters_of_title: c_int, pp_chapters: [*c][*c][*c]libvlc_chapter_description_t) c_int;
pub extern fn libvlc_chapter_descriptions_release(p_chapters: [*c][*c]libvlc_chapter_description_t, i_count: c_uint) void;
pub extern fn libvlc_video_get_crop_geometry(p_mi: ?*libvlc_media_player_t) [*c]u8;
pub extern fn libvlc_video_set_crop_geometry(p_mi: ?*libvlc_media_player_t, psz_geometry: [*c]const u8) void;
pub extern fn libvlc_video_get_teletext(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_set_teletext(p_mi: ?*libvlc_media_player_t, i_page: c_int) void;
pub extern fn libvlc_video_get_track_count(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_get_track_description(p_mi: ?*libvlc_media_player_t) [*c]libvlc_track_description_t;
pub extern fn libvlc_video_get_track(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_set_track(p_mi: ?*libvlc_media_player_t, i_track: c_int) c_int;
pub extern fn libvlc_video_take_snapshot(p_mi: ?*libvlc_media_player_t, num: c_uint, psz_filepath: [*c]const u8, i_width: c_uint, i_height: c_uint) c_int;
pub extern fn libvlc_video_set_deinterlace(p_mi: ?*libvlc_media_player_t, psz_mode: [*c]const u8) void;
pub extern fn libvlc_video_get_marquee_int(p_mi: ?*libvlc_media_player_t, option: c_uint) c_int;
pub extern fn libvlc_video_get_marquee_string(p_mi: ?*libvlc_media_player_t, option: c_uint) [*c]u8;
pub extern fn libvlc_video_set_marquee_int(p_mi: ?*libvlc_media_player_t, option: c_uint, i_val: c_int) void;
pub extern fn libvlc_video_set_marquee_string(p_mi: ?*libvlc_media_player_t, option: c_uint, psz_text: [*c]const u8) void;
pub const libvlc_logo_enable: c_int = 0;
pub const libvlc_logo_file: c_int = 1;
pub const libvlc_logo_x: c_int = 2;
pub const libvlc_logo_y: c_int = 3;
pub const libvlc_logo_delay: c_int = 4;
pub const libvlc_logo_repeat: c_int = 5;
pub const libvlc_logo_opacity: c_int = 6;
pub const libvlc_logo_position: c_int = 7;
pub const enum_libvlc_video_logo_option_t = c_uint;
pub extern fn libvlc_video_get_logo_int(p_mi: ?*libvlc_media_player_t, option: c_uint) c_int;
pub extern fn libvlc_video_set_logo_int(p_mi: ?*libvlc_media_player_t, option: c_uint, value: c_int) void;
pub extern fn libvlc_video_set_logo_string(p_mi: ?*libvlc_media_player_t, option: c_uint, psz_value: [*c]const u8) void;
pub const libvlc_adjust_Enable: c_int = 0;
pub const libvlc_adjust_Contrast: c_int = 1;
pub const libvlc_adjust_Brightness: c_int = 2;
pub const libvlc_adjust_Hue: c_int = 3;
pub const libvlc_adjust_Saturation: c_int = 4;
pub const libvlc_adjust_Gamma: c_int = 5;
pub const enum_libvlc_video_adjust_option_t = c_uint;
pub extern fn libvlc_video_get_adjust_int(p_mi: ?*libvlc_media_player_t, option: c_uint) c_int;
pub extern fn libvlc_video_set_adjust_int(p_mi: ?*libvlc_media_player_t, option: c_uint, value: c_int) void;
pub extern fn libvlc_video_get_adjust_float(p_mi: ?*libvlc_media_player_t, option: c_uint) f32;
pub extern fn libvlc_video_set_adjust_float(p_mi: ?*libvlc_media_player_t, option: c_uint, value: f32) void;
pub const libvlc_AudioOutputDevice_Error: c_int = -1;
pub const libvlc_AudioOutputDevice_Mono: c_int = 1;
pub const libvlc_AudioOutputDevice_Stereo: c_int = 2;
pub const libvlc_AudioOutputDevice_2F2R: c_int = 4;
pub const libvlc_AudioOutputDevice_3F2R: c_int = 5;
pub const libvlc_AudioOutputDevice_5_1: c_int = 6;
pub const libvlc_AudioOutputDevice_6_1: c_int = 7;
pub const libvlc_AudioOutputDevice_7_1: c_int = 8;
pub const libvlc_AudioOutputDevice_SPDIF: c_int = 10;
pub const enum_libvlc_audio_output_device_types_t = c_int;
pub const libvlc_audio_output_device_types_t = enum_libvlc_audio_output_device_types_t;
pub const libvlc_AudioChannel_Error: c_int = -1;
pub const libvlc_AudioChannel_Stereo: c_int = 1;
pub const libvlc_AudioChannel_RStereo: c_int = 2;
pub const libvlc_AudioChannel_Left: c_int = 3;
pub const libvlc_AudioChannel_Right: c_int = 4;
pub const libvlc_AudioChannel_Dolbys: c_int = 5;
pub const enum_libvlc_audio_output_channel_t = c_int;
pub const libvlc_audio_output_channel_t = enum_libvlc_audio_output_channel_t;
pub extern fn libvlc_audio_output_list_get(p_instance: ?*libvlc_instance_t) [*c]libvlc_audio_output_t;
pub extern fn libvlc_audio_output_list_release(p_list: [*c]libvlc_audio_output_t) void;
pub extern fn libvlc_audio_output_set(p_mi: ?*libvlc_media_player_t, psz_name: [*c]const u8) c_int;
pub extern fn libvlc_audio_output_device_enum(mp: ?*libvlc_media_player_t) [*c]libvlc_audio_output_device_t;
pub extern fn libvlc_audio_output_device_list_get(p_instance: ?*libvlc_instance_t, aout: [*c]const u8) [*c]libvlc_audio_output_device_t;
pub extern fn libvlc_audio_output_device_list_release(p_list: [*c]libvlc_audio_output_device_t) void;
pub extern fn libvlc_audio_output_device_set(mp: ?*libvlc_media_player_t, module: [*c]const u8, device_id: [*c]const u8) void;
pub extern fn libvlc_audio_output_device_get(mp: ?*libvlc_media_player_t) [*c]u8;
pub extern fn libvlc_audio_toggle_mute(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_audio_get_mute(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_set_mute(p_mi: ?*libvlc_media_player_t, status: c_int) void;
pub extern fn libvlc_audio_get_volume(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_set_volume(p_mi: ?*libvlc_media_player_t, i_volume: c_int) c_int;
pub extern fn libvlc_audio_get_track_count(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_get_track_description(p_mi: ?*libvlc_media_player_t) [*c]libvlc_track_description_t;
pub extern fn libvlc_audio_get_track(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_set_track(p_mi: ?*libvlc_media_player_t, i_track: c_int) c_int;
pub extern fn libvlc_audio_get_channel(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_set_channel(p_mi: ?*libvlc_media_player_t, channel: c_int) c_int;
pub extern fn libvlc_audio_get_delay(p_mi: ?*libvlc_media_player_t) i64;
pub extern fn libvlc_audio_set_delay(p_mi: ?*libvlc_media_player_t, i_delay: i64) c_int;
pub extern fn libvlc_audio_equalizer_get_preset_count() c_uint;
pub extern fn libvlc_audio_equalizer_get_preset_name(u_index: c_uint) [*c]const u8;
pub extern fn libvlc_audio_equalizer_get_band_count() c_uint;
pub extern fn libvlc_audio_equalizer_get_band_frequency(u_index: c_uint) f32;
pub extern fn libvlc_audio_equalizer_new() ?*libvlc_equalizer_t;
pub extern fn libvlc_audio_equalizer_new_from_preset(u_index: c_uint) ?*libvlc_equalizer_t;
pub extern fn libvlc_audio_equalizer_release(p_equalizer: ?*libvlc_equalizer_t) void;
pub extern fn libvlc_audio_equalizer_set_preamp(p_equalizer: ?*libvlc_equalizer_t, f_preamp: f32) c_int;
pub extern fn libvlc_audio_equalizer_get_preamp(p_equalizer: ?*libvlc_equalizer_t) f32;
pub extern fn libvlc_audio_equalizer_set_amp_at_index(p_equalizer: ?*libvlc_equalizer_t, f_amp: f32, u_band: c_uint) c_int;
pub extern fn libvlc_audio_equalizer_get_amp_at_index(p_equalizer: ?*libvlc_equalizer_t, u_band: c_uint) f32;
pub extern fn libvlc_media_player_set_equalizer(p_mi: ?*libvlc_media_player_t, p_equalizer: ?*libvlc_equalizer_t) c_int;
pub const libvlc_role_None: c_int = 0;
pub const libvlc_role_Music: c_int = 1;
pub const libvlc_role_Video: c_int = 2;
pub const libvlc_role_Communication: c_int = 3;
pub const libvlc_role_Game: c_int = 4;
pub const libvlc_role_Notification: c_int = 5;
pub const libvlc_role_Animation: c_int = 6;
pub const libvlc_role_Production: c_int = 7;
pub const libvlc_role_Accessibility: c_int = 8;
pub const libvlc_role_Test: c_int = 9;
pub const enum_libvlc_media_player_role = c_uint;
pub const libvlc_media_player_role_t = enum_libvlc_media_player_role;
pub extern fn libvlc_media_player_get_role(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_media_player_set_role(p_mi: ?*libvlc_media_player_t, role: c_uint) c_int;
pub const libvlc_media_list_t = struct_libvlc_media_list_t;
pub extern fn libvlc_media_list_new(p_instance: ?*libvlc_instance_t) ?*libvlc_media_list_t;
pub extern fn libvlc_media_list_release(p_ml: ?*libvlc_media_list_t) void;
pub extern fn libvlc_media_list_retain(p_ml: ?*libvlc_media_list_t) void;
pub extern fn libvlc_media_list_set_media(p_ml: ?*libvlc_media_list_t, p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_list_media(p_ml: ?*libvlc_media_list_t) ?*libvlc_media_t;
pub extern fn libvlc_media_list_add_media(p_ml: ?*libvlc_media_list_t, p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_list_insert_media(p_ml: ?*libvlc_media_list_t, p_md: ?*libvlc_media_t, i_pos: c_int) c_int;
pub extern fn libvlc_media_list_remove_index(p_ml: ?*libvlc_media_list_t, i_pos: c_int) c_int;
pub extern fn libvlc_media_list_count(p_ml: ?*libvlc_media_list_t) c_int;
pub extern fn libvlc_media_list_item_at_index(p_ml: ?*libvlc_media_list_t, i_pos: c_int) ?*libvlc_media_t;
pub extern fn libvlc_media_list_index_of_item(p_ml: ?*libvlc_media_list_t, p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_list_is_readonly(p_ml: ?*libvlc_media_list_t) c_int;
pub extern fn libvlc_media_list_lock(p_ml: ?*libvlc_media_list_t) void;
pub extern fn libvlc_media_list_unlock(p_ml: ?*libvlc_media_list_t) void;
pub extern fn libvlc_media_list_event_manager(p_ml: ?*libvlc_media_list_t) ?*libvlc_event_manager_t;
pub const struct_libvlc_media_list_player_t = opaque {};
pub const libvlc_media_list_player_t = struct_libvlc_media_list_player_t;
pub const libvlc_playback_mode_default: c_int = 0;
pub const libvlc_playback_mode_loop: c_int = 1;
pub const libvlc_playback_mode_repeat: c_int = 2;
pub const enum_libvlc_playback_mode_t = c_uint;
pub const libvlc_playback_mode_t = enum_libvlc_playback_mode_t;
pub extern fn libvlc_media_list_player_new(p_instance: ?*libvlc_instance_t) ?*libvlc_media_list_player_t;
pub extern fn libvlc_media_list_player_release(p_mlp: ?*libvlc_media_list_player_t) void;
pub extern fn libvlc_media_list_player_retain(p_mlp: ?*libvlc_media_list_player_t) void;
pub extern fn libvlc_media_list_player_event_manager(p_mlp: ?*libvlc_media_list_player_t) ?*libvlc_event_manager_t;
pub extern fn libvlc_media_list_player_set_media_player(p_mlp: ?*libvlc_media_list_player_t, p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_media_list_player_get_media_player(p_mlp: ?*libvlc_media_list_player_t) ?*libvlc_media_player_t;
pub extern fn libvlc_media_list_player_set_media_list(p_mlp: ?*libvlc_media_list_player_t, p_mlist: ?*libvlc_media_list_t) void;
pub extern fn libvlc_media_list_player_play(p_mlp: ?*libvlc_media_list_player_t) void;
pub extern fn libvlc_media_list_player_pause(p_mlp: ?*libvlc_media_list_player_t) void;
pub extern fn libvlc_media_list_player_set_pause(p_mlp: ?*libvlc_media_list_player_t, do_pause: c_int) void;
pub extern fn libvlc_media_list_player_is_playing(p_mlp: ?*libvlc_media_list_player_t) c_int;
pub extern fn libvlc_media_list_player_get_state(p_mlp: ?*libvlc_media_list_player_t) libvlc_state_t;
pub extern fn libvlc_media_list_player_play_item_at_index(p_mlp: ?*libvlc_media_list_player_t, i_index: c_int) c_int;
pub extern fn libvlc_media_list_player_play_item(p_mlp: ?*libvlc_media_list_player_t, p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_list_player_stop(p_mlp: ?*libvlc_media_list_player_t) void;
pub extern fn libvlc_media_list_player_next(p_mlp: ?*libvlc_media_list_player_t) c_int;
pub extern fn libvlc_media_list_player_previous(p_mlp: ?*libvlc_media_list_player_t) c_int;
pub extern fn libvlc_media_list_player_set_playback_mode(p_mlp: ?*libvlc_media_list_player_t, e_mode: libvlc_playback_mode_t) void;
pub const struct_libvlc_media_library_t = opaque {};
pub const libvlc_media_library_t = struct_libvlc_media_library_t;
pub extern fn libvlc_media_library_new(p_instance: ?*libvlc_instance_t) ?*libvlc_media_library_t;
pub extern fn libvlc_media_library_release(p_mlib: ?*libvlc_media_library_t) void;
pub extern fn libvlc_media_library_retain(p_mlib: ?*libvlc_media_library_t) void;
pub extern fn libvlc_media_library_load(p_mlib: ?*libvlc_media_library_t) c_int;
pub extern fn libvlc_media_library_media_list(p_mlib: ?*libvlc_media_library_t) ?*libvlc_media_list_t;
pub const libvlc_media_discoverer_devices: c_int = 0;
pub const libvlc_media_discoverer_lan: c_int = 1;
pub const libvlc_media_discoverer_podcasts: c_int = 2;
pub const libvlc_media_discoverer_localdirs: c_int = 3;
pub const enum_libvlc_media_discoverer_category_t = c_uint;
pub const libvlc_media_discoverer_category_t = enum_libvlc_media_discoverer_category_t;
pub const struct_libvlc_media_discoverer_description_t = extern struct {
    psz_name: [*c]u8,
    psz_longname: [*c]u8,
    i_cat: libvlc_media_discoverer_category_t,
};
pub const libvlc_media_discoverer_description_t = struct_libvlc_media_discoverer_description_t;
pub const struct_libvlc_media_discoverer_t = opaque {};
pub const libvlc_media_discoverer_t = struct_libvlc_media_discoverer_t;
pub extern fn libvlc_media_discoverer_new(p_inst: ?*libvlc_instance_t, psz_name: [*c]const u8) ?*libvlc_media_discoverer_t;
pub extern fn libvlc_media_discoverer_start(p_mdis: ?*libvlc_media_discoverer_t) c_int;
pub extern fn libvlc_media_discoverer_stop(p_mdis: ?*libvlc_media_discoverer_t) void;
pub extern fn libvlc_media_discoverer_release(p_mdis: ?*libvlc_media_discoverer_t) void;
pub extern fn libvlc_media_discoverer_media_list(p_mdis: ?*libvlc_media_discoverer_t) ?*libvlc_media_list_t;
pub extern fn libvlc_media_discoverer_is_running(p_mdis: ?*libvlc_media_discoverer_t) c_int;
pub extern fn libvlc_media_discoverer_list_get(p_inst: ?*libvlc_instance_t, i_cat: libvlc_media_discoverer_category_t, ppp_services: [*c][*c][*c]libvlc_media_discoverer_description_t) usize;
pub extern fn libvlc_media_discoverer_list_release(pp_services: [*c][*c]libvlc_media_discoverer_description_t, i_count: usize) void;
pub const libvlc_MediaMetaChanged: c_int = 0;
pub const libvlc_MediaSubItemAdded: c_int = 1;
pub const libvlc_MediaDurationChanged: c_int = 2;
pub const libvlc_MediaParsedChanged: c_int = 3;
pub const libvlc_MediaFreed: c_int = 4;
pub const libvlc_MediaStateChanged: c_int = 5;
pub const libvlc_MediaSubItemTreeAdded: c_int = 6;
pub const libvlc_MediaPlayerMediaChanged: c_int = 256;
pub const libvlc_MediaPlayerNothingSpecial: c_int = 257;
pub const libvlc_MediaPlayerOpening: c_int = 258;
pub const libvlc_MediaPlayerBuffering: c_int = 259;
pub const libvlc_MediaPlayerPlaying: c_int = 260;
pub const libvlc_MediaPlayerPaused: c_int = 261;
pub const libvlc_MediaPlayerStopped: c_int = 262;
pub const libvlc_MediaPlayerForward: c_int = 263;
pub const libvlc_MediaPlayerBackward: c_int = 264;
pub const libvlc_MediaPlayerEndReached: c_int = 265;
pub const libvlc_MediaPlayerEncounteredError: c_int = 266;
pub const libvlc_MediaPlayerTimeChanged: c_int = 267;
pub const libvlc_MediaPlayerPositionChanged: c_int = 268;
pub const libvlc_MediaPlayerSeekableChanged: c_int = 269;
pub const libvlc_MediaPlayerPausableChanged: c_int = 270;
pub const libvlc_MediaPlayerTitleChanged: c_int = 271;
pub const libvlc_MediaPlayerSnapshotTaken: c_int = 272;
pub const libvlc_MediaPlayerLengthChanged: c_int = 273;
pub const libvlc_MediaPlayerVout: c_int = 274;
pub const libvlc_MediaPlayerScrambledChanged: c_int = 275;
pub const libvlc_MediaPlayerESAdded: c_int = 276;
pub const libvlc_MediaPlayerESDeleted: c_int = 277;
pub const libvlc_MediaPlayerESSelected: c_int = 278;
pub const libvlc_MediaPlayerCorked: c_int = 279;
pub const libvlc_MediaPlayerUncorked: c_int = 280;
pub const libvlc_MediaPlayerMuted: c_int = 281;
pub const libvlc_MediaPlayerUnmuted: c_int = 282;
pub const libvlc_MediaPlayerAudioVolume: c_int = 283;
pub const libvlc_MediaPlayerAudioDevice: c_int = 284;
pub const libvlc_MediaPlayerChapterChanged: c_int = 285;
pub const libvlc_MediaListItemAdded: c_int = 512;
pub const libvlc_MediaListWillAddItem: c_int = 513;
pub const libvlc_MediaListItemDeleted: c_int = 514;
pub const libvlc_MediaListWillDeleteItem: c_int = 515;
pub const libvlc_MediaListEndReached: c_int = 516;
pub const libvlc_MediaListViewItemAdded: c_int = 768;
pub const libvlc_MediaListViewWillAddItem: c_int = 769;
pub const libvlc_MediaListViewItemDeleted: c_int = 770;
pub const libvlc_MediaListViewWillDeleteItem: c_int = 771;
pub const libvlc_MediaListPlayerPlayed: c_int = 1024;
pub const libvlc_MediaListPlayerNextItemSet: c_int = 1025;
pub const libvlc_MediaListPlayerStopped: c_int = 1026;
pub const libvlc_MediaDiscovererStarted: c_int = 1280;
pub const libvlc_MediaDiscovererEnded: c_int = 1281;
pub const libvlc_RendererDiscovererItemAdded: c_int = 1282;
pub const libvlc_RendererDiscovererItemDeleted: c_int = 1283;
pub const libvlc_VlmMediaAdded: c_int = 1536;
pub const libvlc_VlmMediaRemoved: c_int = 1537;
pub const libvlc_VlmMediaChanged: c_int = 1538;
pub const libvlc_VlmMediaInstanceStarted: c_int = 1539;
pub const libvlc_VlmMediaInstanceStopped: c_int = 1540;
pub const libvlc_VlmMediaInstanceStatusInit: c_int = 1541;
pub const libvlc_VlmMediaInstanceStatusOpening: c_int = 1542;
pub const libvlc_VlmMediaInstanceStatusPlaying: c_int = 1543;
pub const libvlc_VlmMediaInstanceStatusPause: c_int = 1544;
pub const libvlc_VlmMediaInstanceStatusEnd: c_int = 1545;
pub const libvlc_VlmMediaInstanceStatusError: c_int = 1546;
pub const enum_libvlc_event_e = c_uint;
pub const libvlc_event_t = struct_libvlc_event_t;
pub const struct_libvlc_dialog_id = opaque {};
pub const libvlc_dialog_id = struct_libvlc_dialog_id;
pub const LIBVLC_DIALOG_QUESTION_NORMAL: c_int = 0;
pub const LIBVLC_DIALOG_QUESTION_WARNING: c_int = 1;
pub const LIBVLC_DIALOG_QUESTION_CRITICAL: c_int = 2;
pub const enum_libvlc_dialog_question_type = c_uint;
pub const libvlc_dialog_question_type = enum_libvlc_dialog_question_type;
pub const struct_libvlc_dialog_cbs = extern struct {
    pf_display_error: ?*const fn (?*anyopaque, [*c]const u8, [*c]const u8) callconv(.C) void,
    pf_display_login: ?*const fn (?*anyopaque, ?*libvlc_dialog_id, [*c]const u8, [*c]const u8, [*c]const u8, bool) callconv(.C) void,
    pf_display_question: ?*const fn (?*anyopaque, ?*libvlc_dialog_id, [*c]const u8, [*c]const u8, libvlc_dialog_question_type, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.C) void,
    pf_display_progress: ?*const fn (?*anyopaque, ?*libvlc_dialog_id, [*c]const u8, [*c]const u8, bool, f32, [*c]const u8) callconv(.C) void,
    pf_cancel: ?*const fn (?*anyopaque, ?*libvlc_dialog_id) callconv(.C) void,
    pf_update_progress: ?*const fn (?*anyopaque, ?*libvlc_dialog_id, f32, [*c]const u8) callconv(.C) void,
};
pub const libvlc_dialog_cbs = struct_libvlc_dialog_cbs;
pub extern fn libvlc_dialog_set_callbacks(p_instance: ?*libvlc_instance_t, p_cbs: [*c]const libvlc_dialog_cbs, p_data: ?*anyopaque) void;
pub extern fn libvlc_dialog_set_context(p_id: ?*libvlc_dialog_id, p_context: ?*anyopaque) void;
pub extern fn libvlc_dialog_get_context(p_id: ?*libvlc_dialog_id) ?*anyopaque;
pub extern fn libvlc_dialog_post_login(p_id: ?*libvlc_dialog_id, psz_username: [*c]const u8, psz_password: [*c]const u8, b_store: bool) c_int;
pub extern fn libvlc_dialog_post_action(p_id: ?*libvlc_dialog_id, i_action: c_int) c_int;
pub extern fn libvlc_dialog_dismiss(p_id: ?*libvlc_dialog_id) c_int;
pub extern fn libvlc_vlm_release(p_instance: ?*libvlc_instance_t) void;
pub extern fn libvlc_vlm_add_broadcast(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_input: [*c]const u8, psz_output: [*c]const u8, i_options: c_int, ppsz_options: [*c]const [*c]const u8, b_enabled: c_int, b_loop: c_int) c_int;
pub extern fn libvlc_vlm_add_vod(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_input: [*c]const u8, i_options: c_int, ppsz_options: [*c]const [*c]const u8, b_enabled: c_int, psz_mux: [*c]const u8) c_int;
pub extern fn libvlc_vlm_del_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) c_int;
pub extern fn libvlc_vlm_set_enabled(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, b_enabled: c_int) c_int;
pub extern fn libvlc_vlm_set_output(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_output: [*c]const u8) c_int;
pub extern fn libvlc_vlm_set_input(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_input: [*c]const u8) c_int;
pub extern fn libvlc_vlm_add_input(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_input: [*c]const u8) c_int;
pub extern fn libvlc_vlm_set_loop(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, b_loop: c_int) c_int;
pub extern fn libvlc_vlm_set_mux(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_mux: [*c]const u8) c_int;
pub extern fn libvlc_vlm_change_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, psz_input: [*c]const u8, psz_output: [*c]const u8, i_options: c_int, ppsz_options: [*c]const [*c]const u8, b_enabled: c_int, b_loop: c_int) c_int;
pub extern fn libvlc_vlm_play_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) c_int;
pub extern fn libvlc_vlm_stop_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) c_int;
pub extern fn libvlc_vlm_pause_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) c_int;
pub extern fn libvlc_vlm_seek_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, f_percentage: f32) c_int;
pub extern fn libvlc_vlm_show_media(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8) [*c]const u8;
pub extern fn libvlc_vlm_get_media_instance_position(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, i_instance: c_int) f32;
pub extern fn libvlc_vlm_get_media_instance_time(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, i_instance: c_int) c_int;
pub extern fn libvlc_vlm_get_media_instance_length(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, i_instance: c_int) c_int;
pub extern fn libvlc_vlm_get_media_instance_rate(p_instance: ?*libvlc_instance_t, psz_name: [*c]const u8, i_instance: c_int) c_int;
pub extern fn libvlc_vlm_get_event_manager(p_instance: ?*libvlc_instance_t) ?*libvlc_event_manager_t;
pub extern fn libvlc_media_player_get_fps(p_mi: ?*libvlc_media_player_t) f32;
pub extern fn libvlc_media_player_set_agl(p_mi: ?*libvlc_media_player_t, drawable: u32) void;
pub extern fn libvlc_media_player_get_agl(p_mi: ?*libvlc_media_player_t) u32;
pub extern fn libvlc_track_description_release(p_track_description: [*c]libvlc_track_description_t) void;
pub extern fn libvlc_video_get_height(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_get_width(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_video_get_title_description(p_mi: ?*libvlc_media_player_t) [*c]libvlc_track_description_t;
pub extern fn libvlc_video_get_chapter_description(p_mi: ?*libvlc_media_player_t, i_title: c_int) [*c]libvlc_track_description_t;
pub extern fn libvlc_video_set_subtitle_file(p_mi: ?*libvlc_media_player_t, psz_subtitle: [*c]const u8) c_int;
pub extern fn libvlc_toggle_teletext(p_mi: ?*libvlc_media_player_t) void;
pub extern fn libvlc_audio_output_device_count(p_instance: ?*libvlc_instance_t, psz_audio_output: [*c]const u8) c_int;
pub extern fn libvlc_audio_output_device_longname(p_instance: ?*libvlc_instance_t, psz_output: [*c]const u8, i_device: c_int) [*c]u8;
pub extern fn libvlc_audio_output_device_id(p_instance: ?*libvlc_instance_t, psz_audio_output: [*c]const u8, i_device: c_int) [*c]u8;
pub extern fn libvlc_audio_output_get_device_type(p_mi: ?*libvlc_media_player_t) c_int;
pub extern fn libvlc_audio_output_set_device_type(p_mp: ?*libvlc_media_player_t, device_type: c_int) void;
pub extern fn libvlc_media_parse(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_parse_async(p_md: ?*libvlc_media_t) void;
pub extern fn libvlc_media_is_parsed(p_md: ?*libvlc_media_t) c_int;
pub extern fn libvlc_media_get_tracks_info(p_md: ?*libvlc_media_t, tracks: [*c][*c]libvlc_media_track_info_t) c_int;
pub extern fn libvlc_media_list_add_file_content(p_ml: ?*libvlc_media_list_t, psz_uri: [*c]const u8) c_int;
pub extern fn libvlc_media_discoverer_new_from_name(p_inst: ?*libvlc_instance_t, psz_name: [*c]const u8) ?*libvlc_media_discoverer_t;
pub extern fn libvlc_media_discoverer_localized_name(p_mdis: ?*libvlc_media_discoverer_t) [*c]u8;
pub extern fn libvlc_media_discoverer_event_manager(p_mdis: ?*libvlc_media_discoverer_t) ?*libvlc_event_manager_t;
pub extern fn libvlc_wait(p_instance: ?*libvlc_instance_t) void;
pub const struct_libvlc_log_iterator_t = opaque {};
pub const libvlc_log_iterator_t = struct_libvlc_log_iterator_t;
pub const struct_libvlc_log_message_t = extern struct {
    i_severity: c_int,
    psz_type: [*c]const u8,
    psz_name: [*c]const u8,
    psz_header: [*c]const u8,
    psz_message: [*c]const u8,
};
pub const libvlc_log_message_t = struct_libvlc_log_message_t;
pub extern fn libvlc_get_log_verbosity(p_instance: ?*const libvlc_instance_t) c_uint;
pub extern fn libvlc_set_log_verbosity(p_instance: ?*libvlc_instance_t, level: c_uint) void;
pub extern fn libvlc_log_open(p_instance: ?*libvlc_instance_t) ?*libvlc_log_t;
pub extern fn libvlc_log_close(p_log: ?*libvlc_log_t) void;
pub extern fn libvlc_log_count(p_log: ?*const libvlc_log_t) c_uint;
pub extern fn libvlc_log_clear(p_log: ?*libvlc_log_t) void;
pub extern fn libvlc_log_get_iterator(p_log: ?*const libvlc_log_t) ?*libvlc_log_iterator_t;
pub extern fn libvlc_log_iterator_free(p_iter: ?*libvlc_log_iterator_t) void;
pub extern fn libvlc_log_iterator_has_next(p_iter: ?*const libvlc_log_iterator_t) c_int;
pub extern fn libvlc_log_iterator_next(p_iter: ?*libvlc_log_iterator_t, p_buf: [*c]libvlc_log_message_t) [*c]libvlc_log_message_t;
pub extern fn libvlc_playlist_play(p_instance: ?*libvlc_instance_t, i_id: c_int, i_options: c_int, ppsz_options: [*c][*c]u8) void;
pub const __va_list_tag = struct___va_list_tag;
pub const _G_fpos_t = struct__G_fpos_t;
pub const _G_fpos64_t = struct__G_fpos64_t;
pub const _IO_marker = struct__IO_marker;
pub const _IO_codecvt = struct__IO_codecvt;
pub const _IO_wide_data = struct__IO_wide_data;
pub const _IO_FILE = struct__IO_FILE;
pub const libvlc_log_level = enum_libvlc_log_level;
pub const vlc_log_t = struct_vlc_log_t;
pub const libvlc_video_logo_option_t = enum_libvlc_video_logo_option_t;
pub const libvlc_video_adjust_option_t = enum_libvlc_video_adjust_option_t;
pub const libvlc_media_player_role = enum_libvlc_media_player_role;
pub const libvlc_event_e = enum_libvlc_event_e;
