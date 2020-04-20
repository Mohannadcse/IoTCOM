module app_ID10DynamicPage

open IoTBottomUp as base

open cap_userInput
open cap_location
open cap_lock
open cap_runIn
open cap_presenceSensor


one sig app_ID10DynamicPage extends IoTApp {
  
  sendPushMessage : one cap_userInput,
  
  sunMode : one cap_location_attr_mode_val,
  
  people : some cap_presenceSensor,
  
  newAwayMode : one cap_location_attr_mode_val,
  
  runIn : one cap_state,
  
  lock1 : lone cap_lock,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
} {
  rules = r
}


one sig cap_userInput_attr_sendPushMessage extends cap_userInput_attr {}
{
    values = cap_userInput_attr_sendPushMessage_val
} 
abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}



abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newSunriseMode extends cap_state_attr_mode_val {}
one sig cap_state_attr_mode_val_newSunsetMode extends cap_state_attr_mode_val {}
one sig cap_state_attr_mode_val_newAwayMode extends cap_state_attr_mode_val {}

one sig cap_state_attr_sunMode extends cap_state_attr {} {
  values = cap_state_attr_sunMode_val
}
sig cap_state_attr_sunMode_val extends AttrValue {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newMode
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID10DynamicPage.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = app_ID10DynamicPage.newAwayMode
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newMode
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.sunMode
}
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}
one sig r3_cond3 extends r3_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ID10DynamicPage.location
  attribute = cap_location_attr_mode
  value        = app_ID10DynamicPage.newMode
}

one sig r4 extends r {}{
  no triggers
  conditions = r4_cond
  commands   = r4_comm
}




abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_ID10DynamicPage.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_ID10DynamicPage.location
  attribute = cap_location_attr_mode
  value        = app_ID10DynamicPage.newAwayMode
}

one sig r5 extends r {}{
  no triggers
  conditions = r5_cond
  commands   = r5_comm
}




abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newMode
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_ID10DynamicPage.location
  attribute = cap_location_attr_mode
  value        = app_ID10DynamicPage.newMode
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = app_ID10DynamicPage.newAwayMode
}
one sig r6_cond1 extends r6_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.sunMode
}
one sig r6_cond2 extends r6_cond {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  // value        = cap_presenceSensor_attr_presence_val
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newMode
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.state.sunMode
}
one sig r7_cond2 extends r7_cond {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}
one sig r7_cond3 extends r7_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}

one sig r8 extends r {}{
  triggers   = r8_trig
  conditions = r8_cond
  commands   = r8_comm
}

abstract sig r8_trig extends Trigger {}

one sig r8_trig0 extends r8_trig {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r8_cond extends Condition {}

one sig r8_cond0 extends r8_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = app_ID10DynamicPage.newMode
}
one sig r8_cond1 extends r8_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.state.sunMode
}
one sig r8_cond2 extends r8_cond {} {
  capabilities = app_ID10DynamicPage.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}
one sig r8_cond3 extends r8_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r8_comm extends Command {}

one sig r8_comm0 extends r8_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}

one sig r9 extends r {}{
  no triggers
  conditions = r9_cond
  commands   = r9_comm
}




abstract sig r9_cond extends Condition {}

one sig r9_cond0 extends r9_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = app_ID10DynamicPage.newMode
}
one sig r9_cond1 extends r9_cond {} {
  capabilities = app_ID10DynamicPage.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID10DynamicPage.newAwayMode
}

abstract sig r9_comm extends Command {}

one sig r9_comm0 extends r9_comm {} {
  capability   = app_ID10DynamicPage.state
  attribute = cap_state_attr_sunMode
}



