
// filename: cap_button.als
module cap_button
open IoTBottomUp
one sig cap_button extends Capability {}
{
    attributes = cap_button_attr
}
abstract sig cap_button_attr extends Attribute {}
one sig cap_button_attr_button extends cap_button_attr {}
{
    values = cap_button_attr_button_val
} 
abstract sig cap_button_attr_button_val extends AttrValue {}
one sig cap_button_attr_button_val_pushed extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_held extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_double extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_pushed_2x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_pushed_3x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_pushed_4x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_pushed_5x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_pushed_6x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_2x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_3x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_4x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_5x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_6x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_down_hold extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_2x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_3x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_4x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_5x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_6x extends cap_button_attr_button_val {}
one sig cap_button_attr_button_val_up_hold extends cap_button_attr_button_val {}
one sig cap_button_attr_numberOfButtons extends cap_button_attr {}
{
    values = cap_button_attr_numberOfButtons_val
} 
abstract sig cap_button_attr_numberOfButtons_val extends AttrValue {}
one sig cap_button_attr_supportedButtonValues extends cap_button_attr {}
{
    values = cap_button_attr_supportedButtonValues_val
} 
abstract sig cap_button_attr_supportedButtonValues_val extends AttrValue {}
