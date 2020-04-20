
// filename: cap_waterSensor.als
module cap_waterSensor
open IoTBottomUp
one sig cap_waterSensor extends Capability {}
{
    attributes = cap_waterSensor_attr
}
abstract sig cap_waterSensor_attr extends Attribute {}
one sig cap_waterSensor_attr_water extends cap_waterSensor_attr {}
{
    values = cap_waterSensor_attr_water_val
} 
abstract sig cap_waterSensor_attr_water_val extends AttrValue {}
one sig cap_waterSensor_attr_water_val_dry extends cap_waterSensor_attr_water_val {}
one sig cap_waterSensor_attr_water_val_wet extends cap_waterSensor_attr_water_val {}
