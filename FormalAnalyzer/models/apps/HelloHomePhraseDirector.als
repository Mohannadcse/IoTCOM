module app_HelloHomePhraseDirector

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_location
open cap_userInput

one sig app_HelloHomePhraseDirector extends IoTApp {
  location : one cap_location,

  
  people : set cap_presenceSensor,
  
  sendPushMessage : one cap_userInput,
  
  sendPushMessageHome : one cap_userInput,
  
  state : one cap_state,

  homeModeDay : one cap_location_attr_mode_val,
  homeModeNight : one cap_location_attr_mode_val
} {
  rules = r
  //capabilities = people + sendPushMessage + sendPushMessageHome + state
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}
abstract sig cap_userInput_attr_sendPushMessageHome_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessageHome_val_Yes extends cap_userInput_attr_sendPushMessageHome_val {}
one sig cap_userInput_attr_sendPushMessageHome_val_No extends cap_userInput_attr_sendPushMessageHome_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_state_attr_sunMode extends cap_state_attr {} {
  values = cap_state_attr_sunMode_val
}

abstract sig cap_state_attr_sunMode_val extends AttrValue {}
one sig cap_state_attr_sunMode_val_sunset extends cap_state_attr_sunMode_val {}
one sig cap_state_attr_sunMode_val_sunrise extends cap_state_attr_sunMode_val {}




abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_HelloHomePhraseDirector.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HelloHomePhraseDirector.state
  attribute    = cap_state_attr_sunMode
  value        = cap_state_attr_sunMode_val_sunset
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_HelloHomePhraseDirector.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_HelloHomePhraseDirector.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_HelloHomePhraseDirector.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_HelloHomePhraseDirector.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r2_cond extends Condition {}


abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_HelloHomePhraseDirector.state
  attribute    = cap_state_attr_sunMode
  value        = cap_state_attr_sunMode_val_sunrise
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_HelloHomePhraseDirector.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_HelloHomePhraseDirector.state
  attribute    = cap_state_attr_sunMode
  value        = cap_state_attr_sunMode_val_sunrise
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_HelloHomePhraseDirector.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_HelloHomePhraseDirector.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_HelloHomePhraseDirector.state
  attribute    = cap_state_attr_sunMode
  value        = cap_state_attr_sunMode_val_sunrise
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_HelloHomePhraseDirector.state
  attribute    = cap_state_attr_sunMode
  value        = cap_state_attr_sunMode_val_sunset
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_HelloHomePhraseDirector.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



