
// filename: cap_switchLevel.als
module cap_switchLevel
open IoTBottomUp
one sig cap_switchLevel extends Capability {}
{
    attributes = cap_switchLevel_attr
}
abstract sig cap_switchLevel_attr extends Attribute {}
one sig cap_switchLevel_attr_level extends cap_switchLevel_attr {}
{
    values = cap_switchLevel_attr_level_val
} 
abstract sig cap_switchLevel_attr_level_val extends AttrValue {}
one sig cap_switchLevel_attr_level_val0 extends cap_switchLevel_attr_level_val {}
