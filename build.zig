const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    make_example(b, mode, target, "print_version", "examples/print_version.zig");
    make_example(b, mode, target, "player", "examples/player.zig");
}
fn make_example(b: *std.build.Builder,  mode: std.builtin.Mode, target: std.zig.CrossTarget, name: []const u8, path: []const u8) void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    const example = b.addExecutable(name, path);
    example.setBuildMode(mode);
    example.setTarget(target);
    example.linkSystemLibrary("vlc");
    example.addPackagePath("vlc", "src/vlc.zig");
    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = std.fmt.allocPrintZ(alloc, "Run the {s} example", .{name}) catch unreachable;
    const run_step = b.step(name, descr);
    run_step.dependOn(&run_cmd.step);
}
