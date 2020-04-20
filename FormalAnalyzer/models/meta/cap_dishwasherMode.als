
// filename: cap_dishwasherMode.als
module cap_dishwasherMode
open IoTBottomUp
one sig cap_dishwasherMode extends Capability {}
{
    attributes = cap_dishwasherMode_attr
}
abstract sig cap_dishwasherMode_attr extends Attribute {}
one sig cap_dishwasherMode_attr_dishwasherMode extends cap_dishwasherMode_attr {}
{
    values = cap_dishwasherMode_attr_dishwasherMode_val
} 
abstract sig cap_dishwasherMode_attr_dishwasherMode_val extends AttrValue {}
one sig cap_dishwasherMode_attr_dishwasherMode_val_auto extends cap_dishwasherMode_attr_dishwasherMode_val {}
one sig cap_dishwasherMode_attr_dishwasherMode_val_quick extends cap_dishwasherMode_attr_dishwasherMode_val {}
one sig cap_dishwasherMode_attr_dishwasherMode_val_rinse extends cap_dishwasherMode_attr_dishwasherMode_val {}
one sig cap_dishwasherMode_attr_dishwasherMode_val_dry extends cap_dishwasherMode_attr_dishwasherMode_val {}
