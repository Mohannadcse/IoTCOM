module app_SleepingModeChange

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_location

one sig app_SleepingModeChange extends IoTApp {
  location : one cap_location,
  
  theSwitch : one cap_switch,

  sleeping : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = theSwitch + sleeping + location
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SleepingModeChange.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SleepingModeChange.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_SleepingModeChange.sleeping
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SleepingModeChange.location
  attribute    = cap_location_attr_mode
  value        = app_SleepingModeChange.sleeping
}



