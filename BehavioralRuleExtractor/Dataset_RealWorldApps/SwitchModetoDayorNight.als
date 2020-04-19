module app_SwitchModetoDayorNight

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_switch


one sig app_SwitchModetoDayorNight extends IoTApp {
  
  switches : some cap_switch,
  
  switches2 : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = switches + switches2 + state
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


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SwitchModetoDayorNight.switches2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SwitchModetoDayorNight.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



