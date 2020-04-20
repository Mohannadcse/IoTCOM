
// filename: cap_presenceSensor.als
module cap_presenceSensor
open IoTBottomUp
one sig cap_presenceSensor extends Capability {}
{
    attributes = cap_presenceSensor_attr
}
abstract sig cap_presenceSensor_attr extends Attribute {}
one sig cap_presenceSensor_attr_presence extends cap_presenceSensor_attr {}
{
    values = cap_presenceSensor_attr_presence_val
} 
abstract sig cap_presenceSensor_attr_presence_val extends AttrValue {}
one sig cap_presenceSensor_attr_presence_val_present extends cap_presenceSensor_attr_presence_val {}
one sig cap_presenceSensor_attr_presence_val_not_present extends cap_presenceSensor_attr_presence_val {}
