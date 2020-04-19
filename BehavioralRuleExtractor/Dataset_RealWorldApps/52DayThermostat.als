module app_52DayThermostat

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_thermostatMode
open cap_thermostat
open cap_temperatureMeasurement


one sig app_52DayThermostat extends IoTApp {
  
  //thermostat : set cap_thermostat,
  thermostat : set cap_thermostatMode,
  temperatureSensor : one cap_temperatureMeasurement,
} {
  rules = r
  //capabilities = thermostat + temperatureSensor
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_52DayThermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_52DayThermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value        //= cap_temperatureMeasurement_attr_temperature_val_
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_52DayThermostat.thermostat
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_heat
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_52DayThermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  no value        //= cap_thermostat_attr_thermostat_val_no_value
}
/*
one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_52DayThermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_52DayThermostat.thermostat
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_cool
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_52DayThermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value        //= cap_temperatureMeasurement_attr_temperature_val_
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_52DayThermostat.thermostat
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        //= cap_thermostat_attr_thermostat_val_no_value
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_52DayThermostat.temperatureSensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_52DayThermostat.thermostat
  attribute    = cap_thermostatFanMode_attr_thermostatFanMode
  value        = cap_thermostatFanMode_attr_thermostatFanMode_val - cap_thermostatFanMode_attr_thermostatFanMode_val_auto
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_52DayThermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_no_value
}

*/

