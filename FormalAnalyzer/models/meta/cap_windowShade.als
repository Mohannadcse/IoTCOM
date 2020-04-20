
// filename: cap_windowShade.als
module cap_windowShade
open IoTBottomUp
one sig cap_windowShade extends Capability {}
{
    attributes = cap_windowShade_attr
}
abstract sig cap_windowShade_attr extends Attribute {}
one sig cap_windowShade_attr_windowShade extends cap_windowShade_attr {}
{
    values = cap_windowShade_attr_windowShade_val
} 
abstract sig cap_windowShade_attr_windowShade_val extends AttrValue {}
one sig cap_windowShade_attr_windowShade_val_closed extends cap_windowShade_attr_windowShade_val {}
one sig cap_windowShade_attr_windowShade_val_closing extends cap_windowShade_attr_windowShade_val {}
one sig cap_windowShade_attr_windowShade_val_open extends cap_windowShade_attr_windowShade_val {}
one sig cap_windowShade_attr_windowShade_val_opening extends cap_windowShade_attr_windowShade_val {}
one sig cap_windowShade_attr_windowShade_val_partially_open extends cap_windowShade_attr_windowShade_val {}
one sig cap_windowShade_attr_windowShade_val_unknown extends cap_windowShade_attr_windowShade_val {}
