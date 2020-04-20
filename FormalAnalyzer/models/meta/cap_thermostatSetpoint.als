
// filename: cap_thermostatSetpoint.als
module cap_thermostatSetpoint
open IoTBottomUp
one sig cap_thermostatSetpoint extends Capability {}
{
    attributes = cap_thermostatSetpoint_attr
}
abstract sig cap_thermostatSetpoint_attr extends Attribute {}
one sig cap_thermostatSetpoint_attr_thermostatSetpoint extends cap_thermostatSetpoint_attr {}
{
    values = cap_thermostatSetpoint_attr_thermostatSetpoint_val
} 
abstract sig cap_thermostatSetpoint_attr_thermostatSetpoint_val extends AttrValue {}
