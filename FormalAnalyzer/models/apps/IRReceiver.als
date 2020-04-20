module app_IRReceiver

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_switch


lone sig app_IRReceiver extends IoTApp {
  
  switch1 : one cap_switch,
  
  switch2 : one cap_switch,
} {
  rules = r
  //capabilities = switch1 + switch2
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
  capabilities = app_IRReceiver.switch2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_IRReceiver.switch2
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
  capabilities = app_IRReceiver.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_IRReceiver.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_IRReceiver.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_IRReceiver.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}




abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_IRReceiver.switch2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_IRReceiver.switch2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



