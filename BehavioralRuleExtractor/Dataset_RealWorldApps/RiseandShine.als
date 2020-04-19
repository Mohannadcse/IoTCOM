module app_RiseandShine

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_userInput
open cap_motionSensor
open cap_switch
open cap_location

one sig app_RiseandShine extends IoTApp {
  location : one cap_location,
  
  motionSensors : some cap_motionSensor,
  
  switches : some cap_switch,
  timeOfDay : one cap_userInput,
  state : one cap_state,
  dateString : one cap_userInput,
  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = motionSensors + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_userInput_attr_timeOfDay extends cap_userInput_attr {} {
  values = cap_userInput_attr_timeOfDay_val
}
abstract sig cap_userInput_attr_timeOfDay_val extends cap_userInput_attr_value_val {}
one sig range_0,range_1 extends cap_userInput_attr_timeOfDay_val {}


one sig cap_userInput_attr_dateString extends cap_userInput_attr {} {
  values = cap_userInput_attr_dateString_val
}
abstract sig cap_userInput_attr_dateString_val extends cap_userInput_attr_value_val {}


//one sig cap_now_attr_now_val_gt_noValue extends cap_now_attr_now_val {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_RiseandShine.timeOfDay //now
  attribute    = cap_userInput_attr_timeOfDay //cap_now_attr_now
  value        = range_1
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_RiseandShine.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_RiseandShine.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_RiseandShine.location
  attribute    = cap_location_attr_mode
  value        = app_RiseandShine.newMode
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_RiseandShine.timeOfDay //now
  attribute    = cap_userInput_attr_timeOfDay
  value        = range_1
}
/*
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_RiseandShine.state
  attribute    = cap_state_attr_actionTakenOn
  value        = cap_state_attr_actionTakenOn_val - cap_userInput_attr_dateString_val //cap_state_attr_actionTakenOn_val_dateString
}
*/
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_RiseandShine.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_RiseandShine.newMode
}

abstract sig r1_comm extends Command {}
/*
one sig r1_comm0 extends r1_comm {} {
  capability   = app_RiseandShine.state
  attribute    = cap_state_attr_actionTakenOn
  value        = cap_state_attr_actionTakenOn_val_not_null
}
*/
one sig r1_comm1 extends r1_comm {} {
  capability   = app_RiseandShine.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



