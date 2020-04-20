module app_ReadyForRain

open IoTBottomUp as base

open cap_contactSensor


one sig app_ReadyForRain extends IoTApp {
  
  state : one cap_state,
  
  sensors : some cap_contactSensor,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_lastMessage extends cap_state_attr {} {
  values = cap_state_attr_lastMessage_val
}

abstract sig cap_state_attr_lastMessage_val extends AttrValue {}
one sig cap_state_attr_lastMessage_val_0 extends cap_state_attr_lastMessage_val {}

one sig cap_state_attr_lastCheck extends cap_state_attr {} {
  values = cap_state_attr_lastMessage_val
}

abstract sig cap_state_attr_lastCheck_val extends AttrValue {}
one sig cap_state_attr_lastCheck_val_result extends cap_state_attr_lastCheck_val {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ReadyForRain.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ReadyForRain.state
  attribute = cap_state_attr_lastMessage
  value = cap_state_attr_lastMessage_val
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ReadyForRain.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ReadyForRain.state
  attribute    = cap_state_attr_lastCheck
  value        = cap_state_attr_lastCheck_val_result
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ReadyForRain.state
  attribute = cap_state_attr_lastMessage
  value = cap_state_attr_lastMessage_val
}



