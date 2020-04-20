
// filename: cap_mediaPlayback.als
module cap_mediaPlayback
open IoTBottomUp
one sig cap_mediaPlayback extends Capability {}
{
    attributes = cap_mediaPlayback_attr
}
abstract sig cap_mediaPlayback_attr extends Attribute {}
one sig cap_mediaPlayback_attr_playbackStatus extends cap_mediaPlayback_attr {}
{
    values = cap_mediaPlayback_attr_playbackStatus_val
} 
abstract sig cap_mediaPlayback_attr_playbackStatus_val extends AttrValue {}
one sig cap_mediaPlayback_attr_playbackStatus_val_pause extends cap_mediaPlayback_attr_playbackStatus_val {}
one sig cap_mediaPlayback_attr_playbackStatus_val_play extends cap_mediaPlayback_attr_playbackStatus_val {}
one sig cap_mediaPlayback_attr_playbackStatus_val_stop extends cap_mediaPlayback_attr_playbackStatus_val {}
one sig cap_mediaPlayback_attr_playbackStatus_val_fast_forward extends cap_mediaPlayback_attr_playbackStatus_val {}
one sig cap_mediaPlayback_attr_playbackStatus_val_rewind extends cap_mediaPlayback_attr_playbackStatus_val {}
one sig cap_mediaPlayback_attr_supportedPlaybackCommands extends cap_mediaPlayback_attr {}
{
    values = cap_mediaPlayback_attr_supportedPlaybackCommands_val
} 
abstract sig cap_mediaPlayback_attr_supportedPlaybackCommands_val extends AttrValue {}
