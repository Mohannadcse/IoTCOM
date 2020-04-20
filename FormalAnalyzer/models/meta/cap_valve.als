
// filename: cap_valve.als
module cap_valve
open IoTBottomUp
one sig cap_valve extends Capability {}
{
    attributes = cap_valve_attr
}
abstract sig cap_valve_attr extends Attribute {}
one sig cap_valve_attr_valve extends cap_valve_attr {}
{
    values = cap_valve_attr_valve_val
} 
abstract sig cap_valve_attr_valve_val extends AttrValue {}
one sig cap_valve_attr_valve_val_closed extends cap_valve_attr_valve_val {}
one sig cap_valve_attr_valve_val_open extends cap_valve_attr_valve_val {}
