module cap_thermostat

open IoTBottomUp

one sig cap_thermostat extends Capability {} {
  attributes = cap_thermostat_attr
}
abstract sig cap_thermostat_attr extends Attribute {}
one sig cap_thermostat_attr_thermostat extends cap_thermostat_attr {} {
  values = cap_thermostat_attr_thermostat_val
}
one sig cap_thermostat_attr_thermostatOperatingState extends cap_thermostat_attr{} {
  values = cap_thermostat_attr_thermostatOperatingState_val
}

abstract sig cap_thermostat_attr_thermostat_val extends AttrValue {}
one sig cap_thermostat_attr_thermostat_val_setHeatingSetpoint extends cap_thermostat_attr_thermostat_val {}
one sig cap_thermostat_attr_thermostat_val_setCoolingSetpoint extends cap_thermostat_attr_thermostat_val {}

abstract sig cap_thermostat_attr_thermostatOperatingState_val extends AttrValue {}
one sig cap_thermostat_attr_thermostatOperatingState_val_on,cap_thermostat_attr_thermostatOperatingState_val_off extends cap_thermostat_attr_thermostatOperatingState_val {}

