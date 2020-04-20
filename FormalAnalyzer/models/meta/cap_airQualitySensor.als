
// filename: cap_airQualitySensor.als
module cap_airQualitySensor
open IoTBottomUp
one sig cap_airQualitySensor extends Capability {}
{
    attributes = cap_airQualitySensor_attr
}
abstract sig cap_airQualitySensor_attr extends Attribute {}
one sig cap_airQualitySensor_attr_airQuality extends cap_airQualitySensor_attr {}
{
    values = cap_airQualitySensor_attr_airQuality_val
} 
abstract sig cap_airQualitySensor_attr_airQuality_val extends AttrValue {}
