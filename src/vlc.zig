const c = @cImport({
    @cInclude("vlc/libvlc.h");
});

pub const Callback_t = c.libvlc_callback_t;
pub const Instance_t = c.libvlc_instance_t;
pub const Event_t = c.libvlc_event_t;
pub const Event_Type_t = c.libvlc_event_type_t;
pub const Event_Manage_t = c.libvlc_event_manager_t;
pub const Time_t = c.libvlc_time_t;
pub const Log_t = c.libvlc_log_t;

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
pub fn log_get_context(ctx: ?*const Log_t, module: [*c][*c]const u8, file: [*c][*c]const u8, line: [*c]c_uint) void {
    c.libvlc_log_get_context(ctx, module, file, line);
}
pub fn log_get_object(ctx: ?*const Log_t, name: [*c][*c]const u8, header: [*c][*c]const u8, id: [*c]usize) void {
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
pub fn event_type_name(event_type: Event_Type_t) [*c]const u8 {
    return c.libvlc_event_type_name(event_type);
}
pub fn free(ptr: ?*anyopaque) void {
    c.libvlc_free(ptr);
}
pub fn clearerr() void {
    c.libvlc_clearerr();
}
// pub fn vprinterr(fmt: [*c]const u8, ap: [*c]c.struct___va_list_tag) [*c]const u8 {
//     return c.libvlc_vprinterr(fmt, ap);
// }
// pub fn printerr(fmt: [*c]const u8) [*c]const u8 {
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
pub fn add_intf(p_instance: ?*Instance_t, name: [*c]const u8) c_int {
    return c.libvlc_add_intf(p_instance, name);
}
pub fn set_exit_handler(p_instance: ?*Instance_t, cb: ?*const fn (?*anyopaque) callconv(.C) void, @"opaque": ?*anyopaque) void{
    c.libvlc_set_exit_handler(p_instance, cb, @"opaque");
}
pub fn set_user_agent(p_instance: ?*Instance_t, name: [*c]const u8, http: [*c]const u8) void{
    c.libvlc_set_user_agent(p_instance, name, http);
}
pub fn set_app_id(p_instance: ?*Instance_t, id: [*c]const u8, version: [*c]const u8, icon: [*c]const u8) void {
    c.libvlc_set_app_id(p_instance, id, version, icon);
}
