
// filename: cap_relativeHumidityMeasurement.als
module cap_relativeHumidityMeasurement
open IoTBottomUp
one sig cap_relativeHumidityMeasurement extends Capability {}
{
    attributes = cap_relativeHumidityMeasurement_attr
}
abstract sig cap_relativeHumidityMeasurement_attr extends Attribute {}
one sig cap_relativeHumidityMeasurement_attr_humidity extends cap_relativeHumidityMeasurement_attr {}
{
    values = cap_relativeHumidityMeasurement_attr_humidity_val
} 
abstract sig cap_relativeHumidityMeasurement_attr_humidity_val extends AttrValue {}
one sig cap_relativeHumidityMeasurement_attr_humidity_val0 extends cap_relativeHumidityMeasurement_attr_humidity_val {}
