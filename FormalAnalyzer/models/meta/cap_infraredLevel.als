
// filename: cap_infraredLevel.als
module cap_infraredLevel
open IoTBottomUp
one sig cap_infraredLevel extends Capability {}
{
    attributes = cap_infraredLevel_attr
}
abstract sig cap_infraredLevel_attr extends Attribute {}
one sig cap_infraredLevel_attr_infraredLevel extends cap_infraredLevel_attr {}
{
    values = cap_infraredLevel_attr_infraredLevel_val
} 
abstract sig cap_infraredLevel_attr_infraredLevel_val extends AttrValue {}
