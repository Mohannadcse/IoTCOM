module app_ID111DataLeak

open IoTBottomUp as base

open cap_motionSensor
open cap_switchLevel
open cap_runIn


one sig app_ID111DataLeak extends IoTApp {
  
  myswitch : some cap_switchLevel,
  
  runIn : one cap_state,
  
  state : one cap_state,
  
  themotion : one cap_motionSensor,
} {
  rules = r
}



one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_add extends cap_state_attr {} {
  values = cap_state_attr_add_val
}

abstract sig cap_state_attr_add_val extends AttrValue {}
one sig cap_state_attr_add_val_false extends cap_state_attr_add_val {}
one sig cap_state_attr_add_val_true extends cap_state_attr_add_val {}

one sig cap_state_attr_motionDetected extends cap_state_attr {} {
  values = cap_state_attr_motionDetected_val
}

abstract sig cap_state_attr_motionDetected_val extends AttrValue {}
one sig cap_state_attr_motionDetected_val_false extends cap_state_attr_motionDetected_val {}
one sig cap_state_attr_motionDetected_val_true extends cap_state_attr_motionDetected_val {}

one sig cap_state_attr_motionStopTime extends cap_state_attr {} {
  values = cap_state_attr_motionStopTime_val
}

sig cap_state_attr_motionStopTime_val extends AttrValue {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID111DataLeak.themotion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID111DataLeak.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID111DataLeak.themotion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID111DataLeak.state
  attribute = cap_state_attr_motionDetected
  value = cap_state_attr_motionDetected_val_true
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ID111DataLeak.myswitch
  attribute = cap_switchLevel_attr_level
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID111DataLeak.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_ID111DataLeak.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID111DataLeak.myswitch
  attribute = cap_switchLevel_attr_level
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_ID111DataLeak.state
  attribute = cap_state_attr_motionDetected
  value = cap_state_attr_motionDetected_val_false
}



