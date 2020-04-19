module app_homemode_control

open IoTBottomUp as base
open cap_location
open cap_thermostat
open cap_switch


one sig app_homemode_control extends IoTApp {
  
  thermostat : lone cap_thermostat,
  location : one cap_location,
  Toaster : one cap_switch,
} {
  rules = r
  //capabilities = thermostat + Toaster
}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_homemode_control.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_homemode_control.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val//cap_location_attr_mode_val_no_value
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_homemode_control.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_homemode_control.Toaster
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_homemode_control.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_homemode_control.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val//cap_location_attr_mode_val_no_value
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_homemode_control.Toaster
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_homemode_control.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}



