
// filename: cap_thermostatFanMode.als
module cap_thermostatFanMode
open IoTBottomUp
one sig cap_thermostatFanMode extends Capability {}
{
    attributes = cap_thermostatFanMode_attr
}
abstract sig cap_thermostatFanMode_attr extends Attribute {}
one sig cap_thermostatFanMode_attr_thermostatFanMode extends cap_thermostatFanMode_attr {}
{
    values = cap_thermostatFanMode_attr_thermostatFanMode_val
} 
abstract sig cap_thermostatFanMode_attr_thermostatFanMode_val extends AttrValue {}
one sig cap_thermostatFanMode_attr_thermostatFanMode_val_auto extends cap_thermostatFanMode_attr_thermostatFanMode_val {}
one sig cap_thermostatFanMode_attr_thermostatFanMode_val_circulate extends cap_thermostatFanMode_attr_thermostatFanMode_val {}
one sig cap_thermostatFanMode_attr_thermostatFanMode_val_followschedule extends cap_thermostatFanMode_attr_thermostatFanMode_val {}
one sig cap_thermostatFanMode_attr_thermostatFanMode_val_on extends cap_thermostatFanMode_attr_thermostatFanMode_val {}
one sig cap_thermostatFanMode_attr_supportedThermostatFanModes extends cap_thermostatFanMode_attr {}
{
    values = cap_thermostatFanMode_attr_supportedThermostatFanModes_val
} 
abstract sig cap_thermostatFanMode_attr_supportedThermostatFanModes_val extends AttrValue {}
