const std = @import("std");
const vlc = @import("vlc");

// TODO
pub fn main() void {
    const stdout = std.io.getStdOut().writer();
    _ = stdout;
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();
    const args = try std.process.argsAlloc(arena_allocator);
    _ = args;
    // _ = vlc.libvlc_MediaPlayerOpening
}
