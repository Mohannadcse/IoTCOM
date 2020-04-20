
// filename: cap_doorControl.als
module cap_doorControl
open IoTBottomUp
one sig cap_doorControl extends Capability {}
{
    attributes = cap_doorControl_attr
}
abstract sig cap_doorControl_attr extends Attribute {}
one sig cap_doorControl_attr_door extends cap_doorControl_attr {}
{
    values = cap_doorControl_attr_door_val
} 
abstract sig cap_doorControl_attr_door_val extends AttrValue {}
one sig cap_doorControl_attr_door_val_closed extends cap_doorControl_attr_door_val {}
one sig cap_doorControl_attr_door_val_closing extends cap_doorControl_attr_door_val {}
one sig cap_doorControl_attr_door_val_open extends cap_doorControl_attr_door_val {}
one sig cap_doorControl_attr_door_val_opening extends cap_doorControl_attr_door_val {}
one sig cap_doorControl_attr_door_val_unknown extends cap_doorControl_attr_door_val {}
