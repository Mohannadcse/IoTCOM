
// filename: cap_tamperAlert.als
module cap_tamperAlert
open IoTBottomUp
one sig cap_tamperAlert extends Capability {}
{
    attributes = cap_tamperAlert_attr
}
abstract sig cap_tamperAlert_attr extends Attribute {}
one sig cap_tamperAlert_attr_tamper extends cap_tamperAlert_attr {}
{
    values = cap_tamperAlert_attr_tamper_val
} 
abstract sig cap_tamperAlert_attr_tamper_val extends AttrValue {}
one sig cap_tamperAlert_attr_tamper_val_clear extends cap_tamperAlert_attr_tamper_val {}
one sig cap_tamperAlert_attr_tamper_val_detected extends cap_tamperAlert_attr_tamper_val {}
