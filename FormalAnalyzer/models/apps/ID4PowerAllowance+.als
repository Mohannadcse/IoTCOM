module app_ID4PowerAllowance

open IoTBottomUp as base

open cap_switch
open cap_runIn


one sig app_ID4PowerAllowance extends IoTApp {
  
  theSwitch : one cap_switch,
  
  runIn : one cap_state,
} {
  rules = r
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_runIn_attr
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
  capabilities = app_ID4PowerAllowance.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID4PowerAllowance.theSwitch
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r0_comm1 extends r0_comm {} {
  capability   = app_ID4PowerAllowance.theSwitch
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID4PowerAllowance.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID4PowerAllowance.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}



