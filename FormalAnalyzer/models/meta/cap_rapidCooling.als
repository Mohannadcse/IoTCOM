
// filename: cap_rapidCooling.als
module cap_rapidCooling
open IoTBottomUp
one sig cap_rapidCooling extends Capability {}
{
    attributes = cap_rapidCooling_attr
}
abstract sig cap_rapidCooling_attr extends Attribute {}
one sig cap_rapidCooling_attr_rapidCooling extends cap_rapidCooling_attr {}
{
    values = cap_rapidCooling_attr_rapidCooling_val
} 
abstract sig cap_rapidCooling_attr_rapidCooling_val extends AttrValue {}
one sig cap_rapidCooling_attr_rapidCooling_val_off extends cap_rapidCooling_attr_rapidCooling_val {}
one sig cap_rapidCooling_attr_rapidCooling_val_on extends cap_rapidCooling_attr_rapidCooling_val {}
