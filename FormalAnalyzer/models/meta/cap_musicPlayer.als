
// filename: cap_musicPlayer.als
module cap_musicPlayer
open IoTBottomUp
one sig cap_musicPlayer extends Capability {}
{
  attributes = cap_musicPlayer_attr
}
abstract sig cap_musicPlayer_attr extends Attribute {}
one sig cap_musicPlayer_attr_level extends cap_musicPlayer_attr {}
{
  values = cap_musicPlayer_attr_level_val
}
abstract sig cap_musicPlayer_attr_level_val extends AttrValue {}
one sig cap_musicPlayer_attr_mute extends cap_musicPlayer_attr {}
{
  values = cap_musicPlayer_attr_mute_val
}
abstract sig cap_musicPlayer_attr_mute_val extends AttrValue {}
one sig cap_musicPlayer_attr_mute_val_muted extends cap_musicPlayer_attr_mute_val {}
one sig cap_musicPlayer_attr_mute_val_unmuted extends cap_musicPlayer_attr_mute_val {}
one sig cap_musicPlayer_attr_status extends cap_musicPlayer_attr{}
{
  values = cap_musicPlayer_attr_status_val
}
abstract sig cap_musicPlayer_attr_status_val extends AttrValue {}
one sig cap_musicPlayer_attr_trackData extends cap_musicPlayer_attr {}
{
  values = cap_musicPlayer_attr_trackData_val
}
abstract sig cap_musicPlayer_attr_trackData_val extends AttrValue {}
one sig cap_musicPlayer_attr_trackDescription extends cap_musicPlayer_attr {}
{
  values = cap_musicPlayer_attr_trackDescription_val
}
abstract sig cap_musicPlayer_attr_trackDescription_val extends AttrValue {}
one sig cap_musicPlayer_attr_playTrack extends cap_musicPlayer_attr {}
{
  values = cap_musicPlayer_attr_playTrack_val
}
abstract sig cap_musicPlayer_attr_playTrack_val extends AttrValue {}