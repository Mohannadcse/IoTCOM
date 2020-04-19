module app_ThermostatAutoOff

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_thermostatMode
open cap_thermostat
open cap_contactSensor


one sig app_ThermostatAutoOff extends IoTApp {
  
  thermostat : one cap_thermostat,
  thrMode : one cap_thermostatMode,
  sensors : some cap_contactSensor,
  runIn : one cap_state,
  state : one cap_state,
} {
  rules = r
  //capabilities = thermostat + sensors + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_changed extends cap_state_attr {} {
  values = cap_state_attr_changed_val
}

abstract sig cap_state_attr_changed_val extends AttrValue {}
one sig cap_state_attr_changed_val_false extends cap_state_attr_changed_val {}
one sig cap_state_attr_changed_val_true extends cap_state_attr_changed_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ThermostatAutoOff.sensors
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ThermostatAutoOff.state
  attribute    = cap_state_attr_changed
  value        = cap_state_attr_changed_val_true
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ThermostatAutoOff.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ThermostatAutoOff.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ThermostatAutoOff.sensors
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ThermostatAutoOff.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_ThermostatAutoOff.state
  attribute    = cap_state_attr_changed
  value        = cap_state_attr_changed_val_false
}
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_ThermostatAutoOff.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ThermostatAutoOff.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ThermostatAutoOff.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ThermostatAutoOff.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setThermostatMode
}

one sig r2_comm1 extends r2_comm {} {
  capability   = app_ThermostatAutoOff.state
  attribute    = cap_changed_attr_changed
  value        = cap_changed_attr_changed_val_false
}
*/
one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}




abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ThermostatAutoOff.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r3_comm extends Command {}
/*
one sig r3_comm0 extends r3_comm {} {
  capability   = app_ThermostatAutoOff.thrMode
  attribute    = cap_thermostatMode_attr_thermostatMode
  no value        //= cap_thermostatMode_attr_thermostatMode_val_not_null
}
*/
/* Strange there is action off under cap_thermostat
one sig r3_comm1 extends r3_comm {} {
  capability   = app_ThermostatAutoOff.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_off
}
*/
one sig r3_comm0 extends r3_comm {} {
  capability   = app_ThermostatAutoOff.thrMode
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_off
}
/*
one sig r3_comm2 extends r3_comm {} {
  capability   = app_ThermostatAutoOff.state
  attribute    = cap_changed_attr_changed
  value        = cap_changed_attr_changed_val_true
}*/



