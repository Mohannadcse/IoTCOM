
// filename: cap_motionSensor.als
module cap_motionSensor
open IoTBottomUp
one sig cap_motionSensor extends Capability {}
{
    attributes = cap_motionSensor_attr
}
abstract sig cap_motionSensor_attr extends Attribute {}
one sig cap_motionSensor_attr_motion extends cap_motionSensor_attr {}
{
    values = cap_motionSensor_attr_motion_val
} 
abstract sig cap_motionSensor_attr_motion_val extends AttrValue {}
one sig cap_motionSensor_attr_motion_val_active extends cap_motionSensor_attr_motion_val {}
one sig cap_motionSensor_attr_motion_val_inactive extends cap_motionSensor_attr_motion_val {}
