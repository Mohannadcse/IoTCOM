module app_LetThereBeDark

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_LetThereBeDark extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switch1 : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + switch1 + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_wasOn extends cap_state_attr {} {
  values = cap_state_attr_wasOn_val
}

abstract sig cap_state_attr_wasOn_val extends AttrValue {}
one sig cap_state_attr_wasOn_val_true extends cap_state_attr_wasOn_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LetThereBeDark.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LetThereBeDark.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LetThereBeDark.state
  attribute    = cap_state_attr_wasOn
  value        = cap_state_attr_wasOn_val_true
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_LetThereBeDark.switch1
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
  capabilities = app_LetThereBeDark.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LetThereBeDark.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_LetThereBeDark.state
  attribute    = cap_state_attr_wasOn
  value        = cap_state_attr_wasOn_val_true
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LetThereBeDark.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



