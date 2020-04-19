module app_OnceADayLightswDimmer

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switchLevel
open cap_switch


one sig app_OnceADayLightswDimmer extends IoTApp {
  
  MultilevelSwitch : some cap_switchLevel,
  
  switches1 : some cap_switch,
} {
  rules = r
  //capabilities = MultilevelSwitch + switches1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_OnceADayLightswDimmer.switches1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_OnceADayLightswDimmer.switches1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



