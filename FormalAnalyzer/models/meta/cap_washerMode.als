
// filename: cap_washerMode.als
module cap_washerMode
open IoTBottomUp
one sig cap_washerMode extends Capability {}
{
    attributes = cap_washerMode_attr
}
abstract sig cap_washerMode_attr extends Attribute {}
one sig cap_washerMode_attr_washerMode extends cap_washerMode_attr {}
{
    values = cap_washerMode_attr_washerMode_val
} 
abstract sig cap_washerMode_attr_washerMode_val extends AttrValue {}
one sig cap_washerMode_attr_washerMode_val_regular extends cap_washerMode_attr_washerMode_val {}
one sig cap_washerMode_attr_washerMode_val_heavy extends cap_washerMode_attr_washerMode_val {}
one sig cap_washerMode_attr_washerMode_val_rinse extends cap_washerMode_attr_washerMode_val {}
one sig cap_washerMode_attr_washerMode_val_spinDry extends cap_washerMode_attr_washerMode_val {}
