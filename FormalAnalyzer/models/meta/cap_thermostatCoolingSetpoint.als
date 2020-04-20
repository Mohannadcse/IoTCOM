
// filename: cap_thermostatCoolingSetpoint.als
module cap_thermostatCoolingSetpoint
open IoTBottomUp
one sig cap_thermostatCoolingSetpoint extends Capability {}
{
    attributes = cap_thermostatCoolingSetpoint_attr
}
abstract sig cap_thermostatCoolingSetpoint_attr extends Attribute {}
one sig cap_thermostatCoolingSetpoint_attr_coolingSetpoint extends cap_thermostatCoolingSetpoint_attr {}
{
    values = cap_thermostatCoolingSetpoint_attr_coolingSetpoint_val
} 
abstract sig cap_thermostatCoolingSetpoint_attr_coolingSetpoint_val extends AttrValue {}
