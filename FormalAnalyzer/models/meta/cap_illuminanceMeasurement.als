
// filename: cap_illuminanceMeasurement.als
module cap_illuminanceMeasurement
open IoTBottomUp
one sig cap_illuminanceMeasurement extends Capability {}
{
    attributes = cap_illuminanceMeasurement_attr
}
abstract sig cap_illuminanceMeasurement_attr extends Attribute {}
one sig cap_illuminanceMeasurement_attr_illuminance extends cap_illuminanceMeasurement_attr {}
{
    values = cap_illuminanceMeasurement_attr_illuminance_val
} 
abstract sig cap_illuminanceMeasurement_attr_illuminance_val extends AttrValue {}
one sig cap_illuminanceMeasurement_attr_illuminance_val0 extends cap_illuminanceMeasurement_attr_illuminance_val {}
