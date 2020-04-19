module app_DoorKnocker

open IoTBottomUp as base

open cap_userInput


one sig app_DoorKnocker extends IoTApp {
  
  sendPushMessage : one cap_userInput,
  
  state : one cap_state,
} {
  rules = r
}


one sig cap_userInput_attr_sendPushMessage extends cap_userInput_attr {}
{
    values = cap_userInput_attr_sendPushMessage_val
} 
abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}

one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_lastClosed extends cap_state_attr {} {
  values = cap_state_attr_lastClosed_val
}

abstract sig cap_state_attr_lastClosed_val extends AttrValue {}
one sig cap_state_attr_lastClosed_val_0 extends cap_state_attr_lastClosed_val {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DoorKnocker.state
  attribute = cap_state_attr_lastClosed
  value = cap_state_attr_lastClosed_val
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DoorKnocker.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



