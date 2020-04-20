
// filename: cap_colorControl.als
module cap_colorControl
open IoTBottomUp
one sig cap_colorControl extends Capability {}
{
    attributes = cap_colorControl_attr
}
abstract sig cap_colorControl_attr extends Attribute {}
one sig cap_colorControl_attr_color extends cap_colorControl_attr {}
{
    values = cap_colorControl_attr_color_val
} 
abstract sig cap_colorControl_attr_color_val extends AttrValue {}
one sig cap_colorControl_attr_color_val0 extends cap_colorControl_attr_color_val {}

one sig cap_colorControl_attr_hue extends cap_colorControl_attr {}
{
    values = cap_colorControl_attr_hue_val
} 
abstract sig cap_colorControl_attr_hue_val extends AttrValue {}
one sig cap_colorControl_attr_hue_val0 extends cap_colorControl_attr_hue_val {}

one sig cap_colorControl_attr_saturation extends cap_colorControl_attr {}
{
    values = cap_colorControl_attr_saturation_val
} 
abstract sig cap_colorControl_attr_saturation_val extends AttrValue {}
one sig cap_colorControl_attr_saturation_val0 extends cap_colorControl_attr_saturation_val {}
