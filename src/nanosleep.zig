const std = @import("std");
const builtin = @import("builtin");
const math = std.math;
const system = std.os.system;
const timespec = system.timespec;
const errno = system.getErrno;

const size = switch (builtin.os.tag) {
    .windows => c_long,
    else => isize,
};

pub export fn nanosleep(seconds: u64, nanoseconds: u64) void {
    var req = timespec{
        .tv_sec = math.cast(isize, seconds) orelse math.maxInt(isize),
        .tv_nsec = math.cast(size, nanoseconds) orelse math.maxInt(size),
    };
    var rem: timespec = undefined;
    while (true) {
        switch (errno(system.nanosleep(&req, &rem))) {
            .FAULT => unreachable,
            .INVAL => {
                // Sometimes Darwin returns EINVAL for no reason.
                // We treat it as a spurious wakeup.
                return;
            },
            .INTR => {
                req = rem;
                continue;
            },
            // This prong handles success as well as unexpected errors.
            else => return,
        }
    }
}
