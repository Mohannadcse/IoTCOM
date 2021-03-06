module app_BigTurnOFF

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch

open cap_app
open cap_location

one sig app_BigTurnOFF extends IoTApp {
  location : one cap_location,
  app : one cap_app,  
  switches : some cap_switch,
} {
  rules = r
  //capabilities = switches + app
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_BigTurnOFF.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_BigTurnOFF.switches
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
  capabilities = app_BigTurnOFF.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_BigTurnOFF.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



