const std = @import("std");
const vlc = @import("vlc");
const stdout = std.io.getStdOut().writer();
const strcmp = std.mem.eql;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const args = try std.process.argsAlloc(gpa.allocator());
    defer std.process.argsFree(gpa.allocator(), args);

    const vlc_args = [_][*c]const u8{
        // Debug
        "--verbose=2",

        // Apply a video filter.
        //"--video-filter", "sepia",
        //"--sepia-intensity=200"
    };

    var mp: ?*vlc.Media_player_t = null;
    var m: ?*vlc.Media_t = null;

    var argc: usize = 0;
    while (argc < args.len) {
        argc += 1;

        // Help message
        if (args.len <= 1 or strcmp(u8, args[argc], "-h") or strcmp(u8, args[argc], "--help")) {
            usage() catch @panic("Cannot be print help!");
            return;
        }

        // load the vlc engine
        var inst: ?*vlc.Instance_t = vlc.new(@intCast(c_int, argc), &vlc_args);

        // create a new item
        if (strcmp(u8, args[argc], "--input") or strcmp(u8, args[argc], "-i")) {
            if (args.len < 3) {
                try stdout.print("Missing file to exec [argc:{}]!\n", .{args.len});
                break;
            } else {
                argc += 1;
                m = vlc.media_new_path(inst, args[argc]);
            }
        }
        if (strcmp(u8, args[argc], "--url") or strcmp(u8, args[argc], "-u")) {
            if (args.len < 3) {
                try stdout.print("Missing URL file to exec [argc: {}]!\n", .{args.len});
                break;
            } else {
                argc += 1;
                m = vlc.media_new_location(inst, args[argc]);
            }
        }

        // create a media play playing environment
        mp = vlc.media_player_new_from_media(m);

        // no need to keep the media now
        defer vlc.media_release(m);

        // play the media_player
        if (vlc.media_player_play(mp) < 0) @panic("Cannot be played!");

        vlc.sleep(40);

        // stop playing
        vlc.media_player_stop(mp);

        // free the media_player
        defer vlc.media_player_release(mp);

        defer vlc.release(inst);
        break;
    }
}

fn usage() !void {
    try stdout.print(
        \\cli-player [options]
        \\
        \\Options:
        \\  -i, --input: Open local multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -u, --url:   Open online multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -h, --help:  This message
        \\{s}
    , .{"\n\r"});
}
