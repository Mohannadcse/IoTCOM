module app_TurnOffLightswhenweallleave

open IoTBottomUp as base

open cap_userInput
open cap_location
open cap_switch
open cap_presenceSensor

open cap_app

one sig app_TurnOffLightswhenweallleave extends IoTApp {
  
  sendPushMessage : one cap_userInput,
  
  people : some cap_presenceSensor,
  
  app : one cap_app,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
  
  switches : some cap_switch,
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


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}

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
  capabilities = app_TurnOffLightswhenweallleave.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TurnOffLightswhenweallleave.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_TurnOffLightswhenweallleave.location
  attribute = cap_location_attr_mode
  value        = app_TurnOffLightswhenweallleave.newMode
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_TurnOffLightswhenweallleave.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_TurnOffLightswhenweallleave.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_TurnOffLightswhenweallleave.newMode
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_TurnOffLightswhenweallleave.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_TurnOffLightswhenweallleave.state
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
  capabilities = app_TurnOffLightswhenweallleave.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_TurnOffLightswhenweallleave.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_TurnOffLightswhenweallleave.location
  attribute = cap_location_attr_mode
  value        = app_TurnOffLightswhenweallleave.newMode
}



