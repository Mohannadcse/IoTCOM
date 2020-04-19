module app_MakeItSo

open IoTBottomUp as base

open cap_location
open cap_lock
open cap_switch
open cap_thermostat

open cap_app

one sig app_MakeItSo extends IoTApp {
  
  no_value : one cap_location_attr_mode_val,
  
  app : one cap_app,
  
  locks : some cap_lock,
  
  location : one cap_location,
  
  thermostats : some cap_thermostat,
  
  switches : some cap_switch,
} {
  rules = r
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
  capabilities = app_MakeItSo.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MakeItSo.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_MakeItSo.thermostats
  attribute = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val
}
one sig r0_comm2 extends r0_comm {} {
  capability   = app_MakeItSo.locks
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_MakeItSo.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_MakeItSo.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_MakeItSo.thermostats
  attribute = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val
}
one sig r1_comm2 extends r1_comm {} {
  capability   = app_MakeItSo.locks
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val
}



