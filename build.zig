const std = @import("std");

const Options = struct {
    sdl_enabled: bool,
    // capy_enabled: bool, //TODO
};

pub fn build(b: *std.build.Builder) void {
    b.prominent_compile_errors = true;
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    var op = Options{ .sdl_enabled = false };

    const examples = b.option([]const u8, "Example", "Build example: [print-version, cli-player, sdl2-player]") orelse "print-version";
    if (std.mem.eql(u8, examples, "print-version"))
        make_example(b, mode, target, "print_version", "examples/print_version.zig", op);

    if (std.mem.eql(u8, examples, "cli-player"))
        make_example(b, mode, target, "cli-player", "examples/cli_player.zig", op);

    if (std.mem.eql(u8, examples, "sdl-player")) {
        op.sdl_enabled = true;
        make_example(b, mode, target, "sdl-player", "examples/sdl_player.zig", op);
    }
}

fn make_example(b: *std.build.Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget, name: []const u8, path: []const u8, option: Options) void {
    var bf: [100]u8 = undefined;

    const example = b.addExecutable(name, path);
    example.setBuildMode(mode);
    example.setTarget(target);
    example.addPackagePath("vlc", "src/vlc.zig");

    if (option.sdl_enabled) {
        // import SDL bindings
        const sdl = @import("vendor/SDL2-zig/Sdk.zig");

        const sdk = sdl.init(b);
        example.addPackage(sdk.getNativePackage("sdl2"));
        sdk.link(example, .dynamic);
    }

    if (target.isDarwin()) {
        example.linkFramework("Sparkle");
        example.linkSystemLibrary("vlc");
    } else if (target.isWindows()) {
        example.linkSystemLibraryName("vlc");
    } else {
        example.linkSystemLibrary("vlc");
    }

    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = std.fmt.bufPrintZ(&bf, "Run the {s} example", .{name}) catch unreachable;
    const run_step = b.step("run", descr);
    run_step.dependOn(&run_cmd.step);
}
