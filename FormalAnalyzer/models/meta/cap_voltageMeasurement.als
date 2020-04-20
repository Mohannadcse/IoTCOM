
// filename: cap_voltageMeasurement.als
module cap_voltageMeasurement
open IoTBottomUp
one sig cap_voltageMeasurement extends Capability {}
{
    attributes = cap_voltageMeasurement_attr
}
abstract sig cap_voltageMeasurement_attr extends Attribute {}
one sig cap_voltageMeasurement_attr_voltage extends cap_voltageMeasurement_attr {}
{
    values = cap_voltageMeasurement_attr_voltage_val
} 
abstract sig cap_voltageMeasurement_attr_voltage_val extends AttrValue {}
one sig cap_voltageMeasurement_attr_voltage_val0 extends cap_voltageMeasurement_attr_voltage_val {}
