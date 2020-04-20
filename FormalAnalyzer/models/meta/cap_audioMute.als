
// filename: cap_audioMute.als
module cap_audioMute
open IoTBottomUp
one sig cap_audioMute extends Capability {}
{
    attributes = cap_audioMute_attr
}
abstract sig cap_audioMute_attr extends Attribute {}
one sig cap_audioMute_attr_mute extends cap_audioMute_attr {}
{
    values = cap_audioMute_attr_mute_val
} 
abstract sig cap_audioMute_attr_mute_val extends AttrValue {}
one sig cap_audioMute_attr_mute_val_muted extends cap_audioMute_attr_mute_val {}
one sig cap_audioMute_attr_mute_val_unmuted extends cap_audioMute_attr_mute_val {}
