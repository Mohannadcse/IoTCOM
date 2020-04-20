module app_MotionModeChange

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_switch
open cap_location

open cap_userInput

one sig app_MotionModeChange extends IoTApp {
  location : one cap_location,
  
  motionSensors : one cap_motionSensor,
  
  switches : some cap_switch,
  
  //sendPushMessage : one cap_userInput,
  
  state : one cap_state,

  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = motionSensors + switches +  state //sendPushMessage +
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_modeStartTime extends cap_state_attr {} {
  values = cap_state_attr_modeStartTime_val
}

abstract sig cap_state_attr_modeStartTime_val extends AttrValue {}
one sig cap_state_attr_modeStartTime_val_0 extends cap_state_attr_modeStartTime_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_MotionModeChange.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_MotionModeChange.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_MotionModeChange.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MotionModeChange.location
  attribute    = cap_location_attr_mode
  value        = app_MotionModeChange.newMode
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_MotionModeChange.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
/*
one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_MotionModeChange.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_MotionModeChange.state
  attribute    = cap_modeStartTime_attr_modeStartTime
  value        = cap_modeStartTime_attr_modeStartTime_val_not_null
}
*/



