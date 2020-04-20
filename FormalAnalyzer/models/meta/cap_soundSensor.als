
// filename: cap_soundSensor.als
module cap_soundSensor
open IoTBottomUp
one sig cap_soundSensor extends Capability {}
{
    attributes = cap_soundSensor_attr
}
abstract sig cap_soundSensor_attr extends Attribute {}
one sig cap_soundSensor_attr_sound extends cap_soundSensor_attr {}
{
    values = cap_soundSensor_attr_sound_val
} 
abstract sig cap_soundSensor_attr_sound_val extends AttrValue {}
one sig cap_soundSensor_attr_sound_val_detected extends cap_soundSensor_attr_sound_val {}
one sig cap_soundSensor_attr_sound_val_not_detected extends cap_soundSensor_attr_sound_val {}
