module app_Motionbasedthermostat

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_thermostat
open cap_motionSensor
open cap_temperatureMeasurement
open cap_userInput


one sig app_Motionbasedthermostat extends IoTApp {
  
  thermostat : one cap_thermostat,
  
  motionSensor : some cap_motionSensor,
  
  temperatureSensor : one cap_temperatureMeasurement,
  idHeatSet : one cap_userInput,
  idCoolSet : one cap_userInput,
  opHeatSet : one cap_userInput,
  opCoolSet : one cap_userInput,
  idleTimeout : one cap_userInput,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = thermostat + motionSensor + temperatureSensor + idleTimeout + state + idHeatSet + idCoolSet + opHeatSet + opCoolSet
}

one sig cap_state extends cap_runIn {} {
  attributes =  cap_runIn_attr //cap_state_attr +
}
//abstract sig cap_state_attr extends Attribute {}


one sig cap_userInput_attr_idHeatSet extends cap_userInput_attr {} {
  values = cap_userInput_attr_idHeatSet_val
}
abstract sig cap_userInput_attr_idHeatSet_val extends cap_userInput_attr_value_val {}


one sig cap_userInput_attr_idCoolSet extends cap_userInput_attr {} {
  values = cap_userInput_attr_idCoolSet_val
}

one sig cap_userInput_attr_opHeatSet extends cap_userInput_attr {} {
  values = cap_userInput_attr_opHeatSet_val
}

one sig cap_userInput_attr_opCoolSet extends cap_userInput_attr {} {
  values = cap_userInput_attr_opCoolSet_val
}


one sig cap_userInput_attr_opHeatSet_val extends cap_thermostat_attr_thermostat_val_setHeatingSetpoint{} //cap_userInput_attr_value_val,
one sig cap_userInput_attr_opCoolSet_val, cap_userInput_attr_idCoolSet_val extends cap_thermostat_attr_thermostat_val_setCoolingSetpoint{}


one sig cap_userInput_attr_idleTimeout extends cap_userInput_attr {}
{
    values = cap_userInput_attr_idleTimeout_val
} 
abstract sig cap_userInput_attr_idleTimeout_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_idleTimeout_val_0 extends cap_userInput_attr_idleTimeout_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_Motionbasedthermostat.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_Motionbasedthermostat.idleTimeout
  attribute    = cap_userInput_attr_idleTimeout
  value        = cap_userInput_attr_idleTimeout_val_0
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_Motionbasedthermostat.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_Motionbasedthermostat.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_Motionbasedthermostat.idleTimeout
  attribute    = cap_userInput_attr_idleTimeout
  value        = cap_userInput_attr_idleTimeout_val - cap_userInput_attr_idleTimeout_val_0
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_Motionbasedthermostat.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_Motionbasedthermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_currentThermostatFanMode
  value        = cap_thermostat_attr_currentThermostatFanMode_val - cap_thermostat_attr_currentThermostatFanMode_val_fanAuto
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setThermostatFanMode
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_Motionbasedthermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_currentThermostatMode
  value        = cap_thermostat_attr_currentThermostatMode_val_cool
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_Motionbasedthermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setThermostatMode
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_Motionbasedthermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_Motionbasedthermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_currentThermostatMode
  value        = cap_thermostat_attr_currentThermostatMode_val_heat
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_Motionbasedthermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setThermostatMode
}
*/


