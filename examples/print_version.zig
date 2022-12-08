const std = @import("std");
const vlc = @import("vlc");
const zig_version = @import("builtin").zig_version;

pub fn main() void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("LibVLC version: {s}.\n", .{vlc.libvlc_get_version()}) catch @panic("Cannot print libvlc version");
    stdout.print("LibVLC compiler: {s}.\n", .{vlc.libvlc_get_compiler()}) catch @panic("Cannot print libvlccompiler");
    stdout.print("Zig version: {}.\n", .{zig_version}) catch @panic("Cannot print zig version");
}
