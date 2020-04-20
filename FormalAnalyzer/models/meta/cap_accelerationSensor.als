
// filename: cap_accelerationSensor.als
module cap_accelerationSensor
open IoTBottomUp
one sig cap_accelerationSensor extends Capability {}
{
    attributes = cap_accelerationSensor_attr
}
abstract sig cap_accelerationSensor_attr extends Attribute {}
one sig cap_accelerationSensor_attr_acceleration extends cap_accelerationSensor_attr {}
{
    values = cap_accelerationSensor_attr_acceleration_val
} 
abstract sig cap_accelerationSensor_attr_acceleration_val extends AttrValue {}
one sig cap_accelerationSensor_attr_acceleration_val_active extends cap_accelerationSensor_attr_acceleration_val {}
one sig cap_accelerationSensor_attr_acceleration_val_inactive extends cap_accelerationSensor_attr_acceleration_val {}
