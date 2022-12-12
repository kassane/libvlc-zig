const std = @import("std");

const Options = struct {
    sdl_enabled: bool,
    // capy_enabled: bool, //TODO
};

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    var op = Options{ .sdl_enabled = false };

    make_example(b, mode, target, "print_version", "examples/print_version.zig", op);
    make_example(b, mode, target, "cli-player", "examples/cli_player.zig", op);

    const sdl2_isEnabled = b.option(bool, "SDL2", "Use SDL2 [default: off]") orelse false;
    if (sdl2_isEnabled) {
        op.sdl_enabled = sdl2_isEnabled;
        make_example(b, mode, target, "sdl-player", "examples/sdl_player.zig", op);
    }
}

fn make_example(b: *std.build.Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget, name: []const u8, path: []const u8, option: Options) void {
    var bf: [100]u8 = undefined;

    const example = b.addExecutable(name, path);
    example.setBuildMode(mode);
    example.setTarget(target);
    example.addIncludePath("vendor/vlc/include");
    if (option.sdl_enabled) {
        // import SDL bindings
        const sdl = @import("vendor/SDL2-zig/Sdk.zig");

        const sdk = sdl.init(b);
        example.addPackage(sdk.getNativePackage("sdl2"));
        sdk.link(example, .dynamic);
    }
    if (target.isLinux()) {
        example.linkSystemLibraryPkgConfigOnly("libvlc");
    } else {
        example.linkSystemLibrary("vlc");
    }
    example.addPackagePath("vlc", "src/vlc.zig");
    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = std.fmt.bufPrintZ(&bf, "Run the {s} example", .{name}) catch unreachable;
    const run_step = b.step(name, descr);
    run_step.dependOn(&run_cmd.step);
}
