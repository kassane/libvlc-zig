const std = @import("std");
const capy = @import("capy");
const vlc = @import("vlc");

pub usingnamespace capy.cross_platform;

pub fn main() !void {
    try capy.backend.init();
    var window = try capy.Window.init();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const args = try std.process.argsAlloc(gpa.allocator());
    defer std.process.argsFree(gpa.allocator(), args);

    // const vlc_args = [_][*c]const u8{
    //     // Debug
    //     "--verbose=2",

    //     // Apply a video filter.
    //     //"--video-filter", "sepia",
    //     //"--sepia-intensity=200"
    // };

    // var mp: ?*vlc.Media_player_t = null;
    // var m: ?*vlc.Media_t = null;

    window.resize(800, 600);
    window.show();
    capy.runEventLoop();
}