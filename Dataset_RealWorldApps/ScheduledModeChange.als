module app_ScheduledModeChange

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_location


one sig app_ScheduledModeChange extends IoTApp {
  location : one cap_location,
  
  state : one cap_state,

  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}




abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ScheduledModeChange.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ScheduledModeChange.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ScheduledModeChange.location
  attribute    = cap_location_attr_mode
  value        = app_ScheduledModeChange.newMode
}



