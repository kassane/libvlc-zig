const std = @import("std");

pub fn build(b: *std.Build) void {
    if (comptime !checkVersion())
        @compileError("Please! Update zig toolchain >= 0.11!");
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const examples = b.option(
        []const u8,
        "Example",
        "Build example: [print-version, cliPlayer-(c,cpp,zig), sdl2-player]",
    ) orelse "print-version";
    if (std.mem.eql(u8, examples, "print-version"))
        make_example(b, .{
            .sdl_enabled = false,
            .filetype = .zig,
            .mode = optimize,
            .target = target,
            .name = "print_version",
            .path = "examples/print_version.zig",
        });

    if (std.mem.eql(u8, examples, "cliPlayer-zig"))
        make_example(b, .{
            .sdl_enabled = false,
            .filetype = .zig,
            .mode = optimize,
            .target = target,
            .name = "cliPlayer-zig",
            .path = "examples/cli_player.zig",
        });

    if (std.mem.eql(u8, examples, "cliPlayer-c"))
        make_example(b, .{
            .sdl_enabled = false,
            .filetype = .c,
            .mode = optimize,
            .target = target,
            .name = "cliPlayer-c",
            .path = "c_examples/cli_player.c",
        });

    if (std.mem.eql(u8, examples, "cliPlayer-cpp"))
        make_example(b, .{
            .sdl_enabled = false,
            .filetype = .cpp,
            .mode = optimize,
            .target = target,
            .name = "cliPlayer-cpp",
            .path = "c_examples/cli_player.cpp",
        });

    if (std.mem.eql(u8, examples, "sdl-player")) {
        make_example(b, .{
            .sdl_enabled = true,
            .filetype = .zig,
            .mode = optimize,
            .target = target,
            .name = "sdl-player",
            .path = "examples/sdl_player.zig",
        });
    }
}

fn make_example(b: *std.Build, info: BuildInfo) void {
    const example = switch (info.filetype) {
        .c, .cpp => b.addExecutable(.{
            .name = info.name,
            .target = info.target,
            .optimize = info.mode,
        }),
        else => b.addExecutable(.{
            .name = info.name,
            .target = info.target,
            .optimize = info.mode,
            .root_source_file = .{ .path = info.path },
        }),
    };

    if (info.mode != .Debug or info.mode != .ReleaseSafe) {
        example.strip = true;
        example.disable_sanitize_c = true;
    } else example.bundle_compiler_rt = true;

    example.addAnonymousModule("vlc", .{
        .source_file = .{
            .path = "src/vlc.zig",
        },
    });

    if (info.filetype == .c or info.filetype == .cpp)
        example.addCSourceFile(info.path, &.{
            "-Wall",
            "-Werror",
            "-Wextra",
        });

    if (info.sdl_enabled) {
        const libsdl_dep = b.dependency("libsdl", .{
            .target = info.target,
            .optimize = info.mode,
        });
        const libsdl = libsdl_dep.artifact("sdl");
        example.linkLibrary(libsdl);
        example.installLibraryHeaders(libsdl);
    }

    if (info.filetype == .cpp) {
        const libvlcpp_dep = b.dependency("libvlcpp", .{
            .target = info.target,
            .optimize = info.mode,
        });
        const libvlcpp = libvlcpp_dep.artifact("vlcpp");
        example.installLibraryHeaders(libvlcpp);
        example.addIncludePath("zig-out/include");
    }

    if (info.target.isDarwin()) {
        // Custom path
        example.addIncludePath("/usr/local/include");
        example.addLibraryPath("/usr/local/lib");

        // Link Frameworks
        example.linkFramework("Foundation");
        example.linkFramework("Cocoa");
        example.linkFramework("IOKit");

        // Link library
        example.linkSystemLibrary("vlc");
    } else if (info.target.isWindows()) {
        // msys2/clang - CI
        example.addIncludePath(msys2Inc(info.target));
        example.addLibraryPath(msys2Lib(info.target));
        example.linkSystemLibraryName("vlc.dll");
        example.want_lto = false;
    } else {
        example.linkSystemLibrary("vlc");
    }
    if (info.filetype == .cpp)
        example.linkLibCpp()
    else
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
    filetype: SourceType,
    mode: std.builtin.Mode,
    target: std.zig.CrossTarget,
    name: []const u8,
    path: []const u8,
};

const SourceType = enum(u32) {
    zig,
    c,
    cpp,
};

fn msys2Inc(target: std.zig.CrossTarget) []const u8 {
    return switch (target.getCpuArch()) {
        .x86_64 => "D:/msys64/clang64/include",
        .aarch64 => "D:/msys64/clangarm64/include",
        else => "D:/msys64/clang32/include",
    };
}

fn msys2Lib(target: std.zig.CrossTarget) []const u8 {
    return switch (target.getCpuArch()) {
        .x86_64 => "D:/msys64/clang64/lib",
        .aarch64 => "D:/msys64/clangarm64/lib",
        else => "D:/msys64/clang32/lib",
    };
}
