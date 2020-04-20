module app_Intruder

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_location
open cap_userInput

one sig app_Intruder extends IoTApp {
  location : one cap_location,
  
  contacts : some cap_contactSensor,
  
  switch1 : one cap_switch,
  
  sendPushMessage : one cap_userInput,
  
  state : one cap_state,

  //currentMode : one cap_location_attr_mode_val,
  currentMode : one cap_userInput
} {
  rules = r
  //capabilities = contacts + switch1 + sendPushMessage + state + currentMode
}

abstract sig cap_userInput_attr_currentMode_val extends cap_userInput_attr_value_val {}


abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_Intruder.contacts
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_Intruder.location
  attribute    = cap_location_attr_mode
  //value        = app_Intruder.currentMode
  value = cap_userInput_attr_currentMode_val
}
/*
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_Intruder.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_no_value
}
*/

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_Intruder.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



