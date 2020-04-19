module app_SceneMachine

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch

open cap_app

one sig app_SceneMachine extends IoTApp {
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
  capabilities = app_SceneMachine.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SceneMachine.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



