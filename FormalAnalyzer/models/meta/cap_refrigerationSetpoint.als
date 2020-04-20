
// filename: cap_refrigerationSetpoint.als
module cap_refrigerationSetpoint
open IoTBottomUp
one sig cap_refrigerationSetpoint extends Capability {}
{
    attributes = cap_refrigerationSetpoint_attr
}
abstract sig cap_refrigerationSetpoint_attr extends Attribute {}
one sig cap_refrigerationSetpoint_attr_refrigerationSetpoint extends cap_refrigerationSetpoint_attr {}
{
    values = cap_refrigerationSetpoint_attr_refrigerationSetpoint_val
} 
abstract sig cap_refrigerationSetpoint_attr_refrigerationSetpoint_val extends AttrValue {}
