
// filename: cap_thermostatHeatingSetpoint.als
module cap_thermostatHeatingSetpoint
open IoTBottomUp
one sig cap_thermostatHeatingSetpoint extends Capability {}
{
    attributes = cap_thermostatHeatingSetpoint_attr
}
abstract sig cap_thermostatHeatingSetpoint_attr extends Attribute {}
one sig cap_thermostatHeatingSetpoint_attr_heatingSetpoint extends cap_thermostatHeatingSetpoint_attr {}
{
    values = cap_thermostatHeatingSetpoint_attr_heatingSetpoint_val
} 
abstract sig cap_thermostatHeatingSetpoint_attr_heatingSetpoint_val extends AttrValue {}
