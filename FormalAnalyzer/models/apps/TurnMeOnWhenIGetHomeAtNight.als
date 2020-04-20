module app_TurnMeOnWhenIGetHomeAtNight

open IoTBottomUp as base

open cap_switch
open cap_presenceSensor


one sig app_TurnMeOnWhenIGetHomeAtNight extends IoTApp {
  
  state : one cap_state,
  
  presence1 : some cap_presenceSensor,
  
  switch1 : some cap_switch,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_modeStartTime extends cap_state_attr {} {
  values = cap_state_attr_modeStartTime_val
}

abstract sig cap_state_attr_modeStartTime_val extends AttrValue {}
one sig cap_state_attr_modeStartTime_val_0 extends cap_state_attr_modeStartTime_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_TurnMeOnWhenIGetHomeAtNight.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TurnMeOnWhenIGetHomeAtNight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_TurnMeOnWhenIGetHomeAtNight.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_TurnMeOnWhenIGetHomeAtNight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val
}



