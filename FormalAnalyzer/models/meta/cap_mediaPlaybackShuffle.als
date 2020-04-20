
// filename: cap_mediaPlaybackShuffle.als
module cap_mediaPlaybackShuffle
open IoTBottomUp
one sig cap_mediaPlaybackShuffle extends Capability {}
{
    attributes = cap_mediaPlaybackShuffle_attr
}
abstract sig cap_mediaPlaybackShuffle_attr extends Attribute {}
one sig cap_mediaPlaybackShuffle_attr_playbackShuffle extends cap_mediaPlaybackShuffle_attr {}
{
    values = cap_mediaPlaybackShuffle_attr_playbackShuffle_val
} 
abstract sig cap_mediaPlaybackShuffle_attr_playbackShuffle_val extends AttrValue {}
one sig cap_mediaPlaybackShuffle_attr_playbackShuffle_val_disabled extends cap_mediaPlaybackShuffle_attr_playbackShuffle_val {}
one sig cap_mediaPlaybackShuffle_attr_playbackShuffle_val_enabled extends cap_mediaPlaybackShuffle_attr_playbackShuffle_val {}
