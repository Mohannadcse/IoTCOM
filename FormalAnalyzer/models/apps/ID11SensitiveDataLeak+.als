module app_ID11SensitiveDataLeak

open IoTBottomUp as base

open cap_motionSensor
open cap_location
open cap_switch
open cap_runIn


one sig app_ID11SensitiveDataLeak extends IoTApp {
  
  runIn : one cap_state,
  
  motionSensors : some cap_motionSensor,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
  
  switches : some cap_switch,
} {
  rules = r
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}

one sig cap_state_attr_msg extends cap_state_attr {} {
  values = cap_state_attr_msg_val
}

abstract sig cap_state_attr_msg_val extends AttrValue {}
//one sig cap_state_attr_msg_val_switch is on, alert extends cap_state_attr_msg_val {}

one sig cap_state_attr_modeStartTime extends cap_state_attr {} {
  values = cap_state_attr_modeStartTime_val
}

abstract sig cap_state_attr_modeStartTime_val extends AttrValue {}
one sig cap_state_attr_modeStartTime_val_0 extends cap_state_attr_modeStartTime_val {}
one sig cap_state_attr_modeStartTime_val_null extends cap_state_attr_modeStartTime_val {}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID11SensitiveDataLeak.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID11SensitiveDataLeak.state
  attribute    = cap_state_attr_modeStartTime
  value        = cap_state_attr_modeStartTime_val_null
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID11SensitiveDataLeak.state
  attribute    = cap_state_attr_modeStartTime
  value        = cap_state_attr_modeStartTime_val_0
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID11SensitiveDataLeak.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID11SensitiveDataLeak.location
  attribute    = cap_location_attr_mode
  value        = app_ID11SensitiveDataLeak.newMode
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ID11SensitiveDataLeak.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID11SensitiveDataLeak.state
  attribute    = cap_state_attr_modeStartTime
  value        = cap_state_attr_modeStartTime_val_null
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID11SensitiveDataLeak.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r3 extends r {}{
  no triggers
  no conditions
  commands   = r3_comm
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ID11SensitiveDataLeak.state
  attribute    = cap_state_attr_modeStartTime
  value        = cap_state_attr_modeStartTime_val
}



