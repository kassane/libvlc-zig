const std = @import("std");
const vlc = @import("vlc");
const vlcLog = vlc.vlc_log;
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
    var ev: ?*vlc.Event_Manage_t = null;

    var argc: usize = 0;
    while (argc < args.len) {
        argc += 1;

        // Help message
        if (args.len <= 1 or strcmp(u8, args[argc], "-h") or strcmp(u8, args[argc], "--help")) {
            usage() catch @panic("Cannot be print help!");
            return;
        }

        // load the vlc engine
        var inst: ?*vlc.Instance_t = vlc.new(@as(c_int, @intCast(argc)), &vlc_args);

        // create a new item
        if (strcmp(u8, args[argc], "--input") or strcmp(u8, args[argc], "-i")) {
            if (args.len < 3) {
                vlcLog.info("Missing file to exec [argc:{}]!\n", .{args.len});
                break;
            } else {
                argc += 1;
                m = vlc.media_new_path(inst, args[argc]);
            }
        }
        if (strcmp(u8, args[argc], "--url") or strcmp(u8, args[argc], "-u")) {
            if (args.len < 3) {
                vlcLog.info("Missing URL file to exec [argc: {}]!\n", .{args.len});
                break;
            } else {
                argc += 1;
                m = vlc.media_new_location(inst, args[argc]);
            }
        }
        // create a media play playing environment
        mp = vlc.media_player_new_from_media(inst, m);
        ev = vlc.media_player_event_manager(mp);
        _ = vlc.event_attach(ev, @intFromEnum(vlc.Event_e.MediaPlayerEndReached), &handle_vlc_event, null);
        _ = vlc.media_player_play(mp);

        while (vlc.media_player_get_state(mp) != @intFromEnum(vlc.State_t.Ended)) {
            // wait
        }
        // no need to keep the media now
        defer vlc.media_release(inst, m);

        // play the media_player
        if (vlc.media_player_play(mp) < 0) @panic("Cannot be played!");

        // stop playing
        vlc.media_player_stop(inst, mp);

        // free the media_player
        defer vlc.media_player_release(mp);

        defer vlc.release(inst);
        break;
    }
}

fn handle_vlc_event(event: ?*const vlc.Event_t, userdata: ?*anyopaque) callconv(.C) void {
    _ = @TypeOf(userdata);

    if (event.?.*.type == @intFromEnum(vlc.Event_e.MediaPlayerEndReached)) {
        vlcLog.info("Media playback finished.\n", .{});
    }
}

fn usage() !void {
    var bw = std.io.bufferedWriter(std.io.getStdOut().writer());
    const stdout = bw.writer();
    try stdout.print(
        \\cli-player [options]
        \\
        \\Options:
        \\  -i, --input: Open local multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -u, --url:   Open online multimedia [*formats(mp4,mp3,webm,avi,rmvb)]
        \\  -h, --help:  This message
        \\{s}
    , .{"\n\r"});
    try bw.flush();
}
