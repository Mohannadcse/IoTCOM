
// filename: cap_ovenMode.als
module cap_ovenMode
open IoTBottomUp
one sig cap_ovenMode extends Capability {}
{
    attributes = cap_ovenMode_attr
}
abstract sig cap_ovenMode_attr extends Attribute {}
one sig cap_ovenMode_attr_ovenMode extends cap_ovenMode_attr {}
{
    values = cap_ovenMode_attr_ovenMode_val
} 
abstract sig cap_ovenMode_attr_ovenMode_val extends AttrValue {}
one sig cap_ovenMode_attr_ovenMode_val_heating extends cap_ovenMode_attr_ovenMode_val {}
one sig cap_ovenMode_attr_ovenMode_val_grill extends cap_ovenMode_attr_ovenMode_val {}
one sig cap_ovenMode_attr_ovenMode_val_warming extends cap_ovenMode_attr_ovenMode_val {}
one sig cap_ovenMode_attr_ovenMode_val_defrosting extends cap_ovenMode_attr_ovenMode_val {}
