module app_ID3TurnItOnOffandOnEvery30Secs

open IoTBottomUp as base

open cap_switch
open cap_runIn
open cap_contactSensor


one sig app_ID3TurnItOnOffandOnEvery30Secs extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switch1 : one cap_switch,
  
  runIn : one cap_state,
} {
  rules = r
}



one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID3TurnItOnOffandOnEvery30Secs.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID3TurnItOnOffandOnEvery30Secs.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_ID3TurnItOnOffandOnEvery30Secs.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID3TurnItOnOffandOnEvery30Secs.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID3TurnItOnOffandOnEvery30Secs.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ID3TurnItOnOffandOnEvery30Secs.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}



