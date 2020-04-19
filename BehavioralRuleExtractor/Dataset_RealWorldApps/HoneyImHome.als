module app_HoneyImHome

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_switch
open cap_location
open cap_userInput

one sig app_HoneyImHome extends IoTApp {
  location : one cap_location,
  
  people : some cap_presenceSensor,
  
  lights : some cap_switch,  
  state : one cap_state,

  newMode : one cap_location,
} {
  rules = r
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_location_attr_mode_val_newMode extends cap_location_attr_mode_val {}{}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_hasRandomSchedule extends cap_state_attr {} {
  values = cap_state_attr_hasRandomSchedule_val
}

abstract sig cap_state_attr_hasRandomSchedule_val extends AttrValue {}
one sig cap_state_attr_hasRandomSchedule_val_true extends cap_state_attr_hasRandomSchedule_val {}


one sig cap_state_attr_lastStatus extends cap_state_attr {} {
  values = cap_state_attr_lastStatus_val
}

abstract sig cap_state_attr_lastStatus_val extends AttrValue {}
one sig cap_state_attr_lastStatus_val_on extends cap_state_attr_lastStatus_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_HoneyImHome.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_HoneyImHome.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_HoneyImHome.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - cap_location_attr_mode_val_newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HoneyImHome.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_HoneyImHome.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}
/*
one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_HoneyImHome.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val - cap_state_attr_riseTime_val_riseTime.time
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_HoneyImHome.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime.time
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_HoneyImHome.state
  attribute    = cap_riseTime_attr_riseTime
  value        = cap_riseTime_attr_riseTime_val_not_null
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_HoneyImHome.state
  attribute    = cap_setTime_attr_setTime
  value        = cap_setTime_attr_setTime_val_not_null
}
*/
/*
one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_HoneyImHome.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val - cap_state_attr_riseTime_val_riseTime.time
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_HoneyImHome.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_HoneyImHome.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime.time
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_HoneyImHome.state
  attribute    = cap_riseTime_attr_riseTime
  value        = cap_riseTime_attr_riseTime_val_not_null
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_HoneyImHome.state
  attribute    = cap_setTime_attr_setTime
  value        = cap_setTime_attr_setTime_val_not_null
}
*/
one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_HoneyImHome.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_HoneyImHome.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_HoneyImHome.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - cap_location_attr_mode_val_newMode
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_HoneyImHome.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_newMode
}



