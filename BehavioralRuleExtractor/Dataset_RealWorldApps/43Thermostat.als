module app_43Thermostat

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_thermostat


one sig app_43Thermostat extends IoTApp {
  
  thermostat : one cap_thermostat,
} {
  rules = r
  //capabilities = thermostat
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_43Thermostat.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}



