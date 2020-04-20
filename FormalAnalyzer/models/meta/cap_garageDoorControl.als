
// filename: cap_garageDoorControl.als
module cap_garageDoorControl
open IoTBottomUp
one sig cap_garageDoorControl extends Capability {}
{
    attributes = cap_garageDoorControl_attr
}
abstract sig cap_garageDoorControl_attr extends Attribute {}
one sig cap_garageDoorControl_attr_door extends cap_garageDoorControl_attr {}
{
    values = cap_garageDoorControl_attr_door_val
} 
abstract sig cap_garageDoorControl_attr_door_val extends AttrValue {}
one sig cap_garageDoorControl_attr_door_val_closed extends cap_garageDoorControl_attr_door_val {}
one sig cap_garageDoorControl_attr_door_val_closing extends cap_garageDoorControl_attr_door_val {}
one sig cap_garageDoorControl_attr_door_val_open extends cap_garageDoorControl_attr_door_val {}
one sig cap_garageDoorControl_attr_door_val_opening extends cap_garageDoorControl_attr_door_val {}
one sig cap_garageDoorControl_attr_door_val_unknown extends cap_garageDoorControl_attr_door_val {}
