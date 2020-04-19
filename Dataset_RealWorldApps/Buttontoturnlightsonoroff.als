module app_Buttontoturnlightsonoroff

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_switch


one sig app_Buttontoturnlightsonoroff extends IoTApp {
  
  switchOn : set cap_switch,
  
  switchOff : set cap_switch,
} {
  rules = r
  //capabilities = switchOn + switchOff
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
  capability   = app_Buttontoturnlightsonoroff.switchOff
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_Buttontoturnlightsonoroff.switchOn
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_Buttontoturnlightsonoroff.switchOn
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_Buttontoturnlightsonoroff.switchOn
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_Buttontoturnlightsonoroff.switchOn
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



