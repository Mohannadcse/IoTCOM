
// filename: cap_ovenSetpoint.als
module cap_ovenSetpoint
open IoTBottomUp
one sig cap_ovenSetpoint extends Capability {}
{
    attributes = cap_ovenSetpoint_attr
}
abstract sig cap_ovenSetpoint_attr extends Attribute {}
one sig cap_ovenSetpoint_attr_ovenSetpoint extends cap_ovenSetpoint_attr {}
{
    values = cap_ovenSetpoint_attr_ovenSetpoint_val
} 
abstract sig cap_ovenSetpoint_attr_ovenSetpoint_val extends AttrValue {}
