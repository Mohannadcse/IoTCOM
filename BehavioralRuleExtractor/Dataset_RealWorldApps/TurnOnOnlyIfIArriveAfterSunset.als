module app_TurnOnOnlyIfIArriveAfterSunset

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_switch


one sig app_TurnOnOnlyIfIArriveAfterSunset extends IoTApp {
  
  presence1 : some cap_presenceSensor,
  
  switch1 : some cap_switch,
} {
  rules = r
  //capabilities = presence1 + switch1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_TurnOnOnlyIfIArriveAfterSunset.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TurnOnOnlyIfIArriveAfterSunset.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_TurnOnOnlyIfIArriveAfterSunset.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_TurnOnOnlyIfIArriveAfterSunset.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



