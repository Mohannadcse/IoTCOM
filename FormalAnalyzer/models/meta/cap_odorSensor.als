
// filename: cap_odorSensor.als
module cap_odorSensor
open IoTBottomUp
one sig cap_odorSensor extends Capability {}
{
    attributes = cap_odorSensor_attr
}
abstract sig cap_odorSensor_attr extends Attribute {}
one sig cap_odorSensor_attr_odorLevel extends cap_odorSensor_attr {}
{
    values = cap_odorSensor_attr_odorLevel_val
} 
abstract sig cap_odorSensor_attr_odorLevel_val extends AttrValue {}
