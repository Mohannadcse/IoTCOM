
// filename: cap_carbonDioxideMeasurement.als
module cap_carbonDioxideMeasurement
open IoTBottomUp
one sig cap_carbonDioxideMeasurement extends Capability {}
{
    attributes = cap_carbonDioxideMeasurement_attr
}
abstract sig cap_carbonDioxideMeasurement_attr extends Attribute {}
one sig cap_carbonDioxideMeasurement_attr_carbonDioxide extends cap_carbonDioxideMeasurement_attr {}
{
    values = cap_carbonDioxideMeasurement_attr_carbonDioxide_val
} 
abstract sig cap_carbonDioxideMeasurement_attr_carbonDioxide_val extends AttrValue {}
one sig cap_carbonDioxideMeasurement_attr_carbonDioxide_val0 extends cap_carbonDioxideMeasurement_attr_carbonDioxide_val {}
