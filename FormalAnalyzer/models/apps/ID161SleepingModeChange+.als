module app_ID161SleepingModeChange

open IoTBottomUp as base

open cap_location
open cap_switch


one sig app_ID161SleepingModeChange extends IoTApp {
  
  theSwitch : one cap_switch,
  
  onMode : one cap_location_attr_mode_val,
  
  location : one cap_location,
  
  offMode : one cap_location_attr_mode_val,
} {
  rules = r
}







// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID161SleepingModeChange.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID161SleepingModeChange.location
  attribute = cap_location_attr_mode
  value        = app_ID161SleepingModeChange.offMode
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID161SleepingModeChange.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID161SleepingModeChange.location
  attribute = cap_location_attr_mode
  value        = app_ID161SleepingModeChange.onMode
}



