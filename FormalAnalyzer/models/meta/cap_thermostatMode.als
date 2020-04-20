
// filename: cap_thermostatMode.als
module cap_thermostatMode
open IoTBottomUp
one sig cap_thermostatMode extends Capability {}
{
    attributes = cap_thermostatMode_attr
}
abstract sig cap_thermostatMode_attr extends Attribute {}
one sig cap_thermostatMode_attr_thermostatMode extends cap_thermostatMode_attr {}
{
    values = cap_thermostatMode_attr_thermostatMode_val
} 
abstract sig cap_thermostatMode_attr_thermostatMode_val extends AttrValue {}
one sig cap_thermostatMode_attr_thermostatMode_val_auto extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_cool extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_eco extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_rush_hour extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_emergency_heat extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_heat extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_thermostatMode_val_off extends cap_thermostatMode_attr_thermostatMode_val {}
one sig cap_thermostatMode_attr_supportedThermostatModes extends cap_thermostatMode_attr {}
{
    values = cap_thermostatMode_attr_supportedThermostatModes_val
} 
abstract sig cap_thermostatMode_attr_supportedThermostatModes_val extends AttrValue {}
