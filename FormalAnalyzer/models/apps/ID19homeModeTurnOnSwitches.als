module app_ID19homeModeTurnOnSwitches

open IoTBottomUp as base

open cap_location
open cap_switch


one sig app_ID19homeModeTurnOnSwitches extends IoTApp {
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
  
  switches : some cap_switch,
} {
  rules = r
}







// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID19homeModeTurnOnSwitches.location
  attribute    = cap_location_attr_mode
  value        = app_ID19homeModeTurnOnSwitches.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID19homeModeTurnOnSwitches.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}



