module app_WalkGentleIntoThatGoodNight

open IoTBottomUp as base

open cap_switch

open cap_app

one sig app_WalkGentleIntoThatGoodNight extends IoTApp {
  
  app : one cap_app,
  
  state : one cap_state,
  
  switches : set cap_switch,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_WalkGentleIntoThatGoodNight.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_WalkGentleIntoThatGoodNight.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val
}



