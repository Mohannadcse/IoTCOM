
// filename: cap_carbonMonoxideMeasurement.als
module cap_carbonMonoxideMeasurement
open IoTBottomUp
one sig cap_carbonMonoxideMeasurement extends Capability {}
{
    attributes = cap_carbonMonoxideMeasurement_attr
}
abstract sig cap_carbonMonoxideMeasurement_attr extends Attribute {}
one sig cap_carbonMonoxideMeasurement_attr_carbonMonoxideLevel extends cap_carbonMonoxideMeasurement_attr {}
{
    values = cap_carbonMonoxideMeasurement_attr_carbonMonoxideLevel_val
} 
abstract sig cap_carbonMonoxideMeasurement_attr_carbonMonoxideLevel_val extends AttrValue {}
one sig cap_carbonMonoxideMeasurement_attr_carbonMonoxideLevel_val0 extends cap_carbonMonoxideMeasurement_attr_carbonMonoxideLevel_val {}
