module app_ID8

open IoTBottomUp as base

open cap_userInput
open cap_location
open cap_runIn
open cap_presenceSensor


one sig app_ID8 extends IoTApp {
  
  sendPushMessage : one cap_userInput,
  
  people : some cap_presenceSensor,
  
  runIn : one cap_state,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
} {
  rules = r
}

abstract sig cap_userInput_attr_sendPushMessage_val extends AttrValue {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID8.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID8.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID8.newMode
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ID8.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID8.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



