
// filename: cap_mediaPlaybackRepeat.als
module cap_mediaPlaybackRepeat
open IoTBottomUp
one sig cap_mediaPlaybackRepeat extends Capability {}
{
    attributes = cap_mediaPlaybackRepeat_attr
}
abstract sig cap_mediaPlaybackRepeat_attr extends Attribute {}
one sig cap_mediaPlaybackRepeat_attr_playbackRepeatMode extends cap_mediaPlaybackRepeat_attr {}
{
    values = cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val
} 
abstract sig cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val extends AttrValue {}
one sig cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val_all extends cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val {}
one sig cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val_off extends cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val {}
one sig cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val_one extends cap_mediaPlaybackRepeat_attr_playbackRepeatMode_val {}
