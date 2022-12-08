const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    make_example(b, "print_version", "examples/print_version.zig");
}
fn make_example(b: *std.build.Builder, name: []const u8, path: []const u8) void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
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
