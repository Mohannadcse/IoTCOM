
// filename: cap_switch.als
module cap_switch
open IoTBottomUp
one sig cap_switch extends Capability {}
{
    attributes = cap_switch_attr
}
abstract sig cap_switch_attr extends Attribute {}
one sig cap_switch_attr_switch extends cap_switch_attr {}
{
    values = cap_switch_attr_switch_val
} 
abstract sig cap_switch_attr_switch_val extends AttrValue {}
one sig cap_switch_attr_switch_val_on extends cap_switch_attr_switch_val {}
one sig cap_switch_attr_switch_val_off extends cap_switch_attr_switch_val {}
