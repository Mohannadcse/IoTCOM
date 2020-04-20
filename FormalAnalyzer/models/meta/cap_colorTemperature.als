
// filename: cap_colorTemperature.als
module cap_colorTemperature
open IoTBottomUp
one sig cap_colorTemperature extends Capability {}
{
    attributes = cap_colorTemperature_attr
}
abstract sig cap_colorTemperature_attr extends Attribute {}
one sig cap_colorTemperature_attr_colorTemperature extends cap_colorTemperature_attr {}
{
    values = cap_colorTemperature_attr_colorTemperature_val
} 
abstract sig cap_colorTemperature_attr_colorTemperature_val extends AttrValue {}
