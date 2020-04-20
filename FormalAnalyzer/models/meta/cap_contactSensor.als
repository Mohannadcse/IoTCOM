
// filename: cap_contactSensor.als
module cap_contactSensor
open IoTBottomUp
one sig cap_contactSensor extends Capability {}
{
    attributes = cap_contactSensor_attr
}
abstract sig cap_contactSensor_attr extends Attribute {}
one sig cap_contactSensor_attr_contact extends cap_contactSensor_attr {}
{
    values = cap_contactSensor_attr_contact_val
} 
abstract sig cap_contactSensor_attr_contact_val extends AttrValue {}
one sig cap_contactSensor_attr_contact_val_closed extends cap_contactSensor_attr_contact_val {}
one sig cap_contactSensor_attr_contact_val_open extends cap_contactSensor_attr_contact_val {}
