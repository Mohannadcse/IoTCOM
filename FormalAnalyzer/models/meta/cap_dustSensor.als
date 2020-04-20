
// filename: cap_dustSensor.als
module cap_dustSensor
open IoTBottomUp
one sig cap_dustSensor extends Capability {}
{
    attributes = cap_dustSensor_attr
}
abstract sig cap_dustSensor_attr extends Attribute {}
one sig cap_dustSensor_attr_fineDustLevel extends cap_dustSensor_attr {}
{
    values = cap_dustSensor_attr_fineDustLevel_val
} 
abstract sig cap_dustSensor_attr_fineDustLevel_val extends AttrValue {}
one sig cap_dustSensor_attr_dustLevel extends cap_dustSensor_attr {}
{
    values = cap_dustSensor_attr_dustLevel_val
} 
abstract sig cap_dustSensor_attr_dustLevel_val extends AttrValue {}
