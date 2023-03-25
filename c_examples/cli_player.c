#include <stdio.h>
#include <stdlib.h>
#include <vlc/vlc.h>

typedef struct {
    int counter;
} user_data_t;

static void handle_vlc_event(const struct libvlc_event_t* event, void* userdata) {
    user_data_t* user_data = (user_data_t*) userdata;

    if (event->type == libvlc_MediaPlayerEndReached) {
        printf("Media playback finished.\n");
        printf("Counter value: %d\n", user_data->counter);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <media_file_path>\n", argv[0]);
        return 1;
    }

    libvlc_instance_t* vlc_instance = libvlc_new(0, NULL);
    libvlc_media_player_t* vlc_player = libvlc_media_player_new(vlc_instance);

    char* media_file_path = argv[1];
    libvlc_media_t* media = libvlc_media_new_path(vlc_instance, media_file_path);
    libvlc_media_player_set_media(vlc_player, media);

    user_data_t user_data = { 42 };
    libvlc_event_manager_t* em = libvlc_media_player_event_manager(vlc_player);
    libvlc_event_attach(em, libvlc_MediaPlayerEndReached, handle_vlc_event, &user_data);

    libvlc_media_player_play(vlc_player);

    while (libvlc_media_player_get_state(vlc_player) != libvlc_Ended) {
        // wait
    }

    libvlc_media_release(media);
    libvlc_media_player_release(vlc_player);
    libvlc_release(vlc_instance);

    return 0;
}