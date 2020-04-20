
// filename: cap_formaldehydeMeasurement.als
module cap_formaldehydeMeasurement
open IoTBottomUp
one sig cap_formaldehydeMeasurement extends Capability {}
{
    attributes = cap_formaldehydeMeasurement_attr
}
abstract sig cap_formaldehydeMeasurement_attr extends Attribute {}
one sig cap_formaldehydeMeasurement_attr_formaldehydeLevel extends cap_formaldehydeMeasurement_attr {}
{
    values = cap_formaldehydeMeasurement_attr_formaldehydeLevel_val
} 
abstract sig cap_formaldehydeMeasurement_attr_formaldehydeLevel_val extends AttrValue {}
