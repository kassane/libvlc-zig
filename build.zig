const std = @import("std");

pub fn build(b: *std.Build) void {
    if (comptime !checkVersion())
        @compileError("Please! Update zig toolchain >= 0.11!");
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const examples = b.option([]const u8, "Example", "Build example: [print-version, cli-player, sdl2-player]") orelse "print-version";
    if (std.mem.eql(u8, examples, "print-version"))
        make_example(b, .{
            .sdl_enabled = false,
            .mode = optimize,
            .target = target,
            .name = "print_version",
            .path = "examples/print_version.zig",
        });

    if (std.mem.eql(u8, examples, "cli-player"))
        make_example(b, .{
            .sdl_enabled = false,
            .mode = optimize,
            .target = target,
            .name = "cli-player",
            .path = "examples/cli_player.zig",
        });

    if (std.mem.eql(u8, examples, "sdl-player")) {
        make_example(b, .{
            .sdl_enabled = true,
            .mode = optimize,
            .target = target,
            .name = "sdl-player",
            .path = "examples/sdl_player.zig",
        });
    }
}

fn make_example(b: *std.Build, info: BuildInfo) void {
    const example = b.addExecutable(.{
        .name = info.name,
        .target = info.target,
        .optimize = info.mode,
        .root_source_file = .{ .path = info.path },
    });

    example.addAnonymousModule("vlc", .{
        .source_file = .{
            .path = "src/vlc.zig",
        },
    });

    const libsdl_dep = b.dependency("libsdl", .{
        .target = info.target,
        .optimize = info.optimize,
    });
    const libsdl = libsdl_dep.artifact("sdl");
    if (info.sdl_enabled) {
        example.linkLibrary(libsdl);
        example.installLibraryHeaders(libsdl);
    }

    if (info.target.isDarwin()) {
        // Custom path
        example.addIncludePath("/usr/local/include");
        example.addLibraryPath("/usr/local/lib");
        // Link Frameworks
        example.linkFramework("Foundation");
        example.linkFramework("Cocoa");
        example.linkFramework("IOKit");
        // example.linkFramework("Sparkle");
        // Link library
        example.linkSystemLibrary("vlc");
    } else if (info.target.isWindows()) {
        // msys2/clang - CI
        example.addIncludePath(switch (info.target.getCpuArch()) {
            .x86_64 => "D:/msys64/clang64/include",
            else => "D:/msys64/clang32/include",
        });
        example.addLibraryPath(switch (info.target.getCpuArch()) {
            .x86_64 => "D:/msys64/clang64/lib",
            else => "D:/msys64/clang32/lib",
        });
        example.linkSystemLibraryName("vlc.dll");
        example.want_lto = false;
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

    var descr = b.fmt("Run the {s} example", .{info.name});
    const run_step = b.step("run", descr);
    run_step.dependOn(&run_cmd.step);
}

fn checkVersion() bool {
    const builtin = @import("builtin");
    if (!@hasDecl(builtin, "zig_version")) {
        return false;
    }

    const needed_version = std.SemanticVersion.parse("0.11.0-dev.2191") catch unreachable;
    const version = builtin.zig_version;
    const order = version.order(needed_version);
    return order != .lt;
}

const BuildInfo = struct {
    sdl_enabled: bool,
    // capy_enabled: bool, //TODO
    mode: std.builtin.Mode,
    target: std.zig.CrossTarget,
    name: []const u8,
    path: []const u8,
};
