
// filename: cap_dryerMode.als
module cap_dryerMode
open IoTBottomUp
one sig cap_dryerMode extends Capability {}
{
    attributes = cap_dryerMode_attr
}
abstract sig cap_dryerMode_attr extends Attribute {}
one sig cap_dryerMode_attr_dryerMode extends cap_dryerMode_attr {}
{
    values = cap_dryerMode_attr_dryerMode_val
} 
abstract sig cap_dryerMode_attr_dryerMode_val extends AttrValue {}
one sig cap_dryerMode_attr_dryerMode_val_regular extends cap_dryerMode_attr_dryerMode_val {}
one sig cap_dryerMode_attr_dryerMode_val_lowHeat extends cap_dryerMode_attr_dryerMode_val {}
one sig cap_dryerMode_attr_dryerMode_val_highHeat extends cap_dryerMode_attr_dryerMode_val {}
