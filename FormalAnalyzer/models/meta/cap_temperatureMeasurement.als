
// filename: cap_temperatureMeasurement.als
module cap_temperatureMeasurement
open IoTBottomUp
one sig cap_temperatureMeasurement extends Capability {}
{
    attributes = cap_temperatureMeasurement_attr
}
abstract sig cap_temperatureMeasurement_attr extends Attribute {}
one sig cap_temperatureMeasurement_attr_temperature extends cap_temperatureMeasurement_attr {}
{
    values = cap_temperatureMeasurement_attr_temperature_val
} 
abstract sig cap_temperatureMeasurement_attr_temperature_val extends AttrValue {}
one sig cap_temperatureMeasurement_attr_temperature_val_low,cap_temperatureMeasurement_attr_temperature_val_med,cap_temperatureMeasurement_attr_temperature_val_high extends cap_temperatureMeasurement_attr_temperature_val {}
