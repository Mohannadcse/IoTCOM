module app_NestAutoPresence

open IoTBottomUp as base

open cap_presenceSensor


one sig app_NestAutoPresence extends IoTApp {
  
  state : one cap_state,
  
  presence1 : some cap_presenceSensor,
  
  nest1 : one cap_presenceSensor,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_NestAutoPresence.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_NestAutoPresence.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_NestAutoPresence.nest1
  attribute = cap_presenceSensor_attr_presence
  value = cap_presenceSensor_attr_presence_val_not_present
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_NestAutoPresence.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_NestAutoPresence.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_NestAutoPresence.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_NestAutoPresence.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_NestAutoPresence.nest1
  attribute = cap_presenceSensor_attr_presence
  value = cap_presenceSensor_attr_presence_val_present
}



