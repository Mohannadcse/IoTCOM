module app_IlluminatedResponsetoUnexpectedVisitors

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_switch
open cap_switch
open cap_switch
open cap_switch


one sig app_IlluminatedResponsetoUnexpectedVisitors extends IoTApp {
  
  motion : one cap_motionSensor,
  
  switch1 : one cap_switch,
  
  switch2 : one cap_switch,
  
  switch3 : one cap_switch,
  
  switch4 : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = motion + switch1 + switch2 + switch3 + switch4 + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_escalationLevel extends cap_state_attr {} {
  values = cap_state_attr_escalationLevel_val
}

abstract sig cap_state_attr_escalationLevel_val extends AttrValue {}
one sig cap_state_attr_escalationLevel_val_0 extends cap_state_attr_escalationLevel_val {}
one sig cap_state_attr_escalationLevel_val_1 extends cap_state_attr_escalationLevel_val {}
one sig cap_state_attr_escalationLevel_val_2 extends cap_state_attr_escalationLevel_val {}


one sig range_0,range_1,range_2,range_3 extends cap_state_attr_escalationLevel_val {}

// application rules base class

abstract sig r extends Rule {}


one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_state_attr_escalationLevel
  value        = cap_state_attr_escalationLevel_val - range_0
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r3_cond extends Condition {}


abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch3
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r3_comm1 extends r3_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch4
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
/*
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_state_attr_escalationLevel
  value        = cap_state_attr_escalationLevel_val_lt_1
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_escalationLevel_attr_escalationLevel
  value        = cap_escalationLevel_attr_escalationLevel_val_not_null
}
*/
one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_state_attr_escalationLevel
  value        = range_0 + range_1
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r6_cond extends Condition {}


abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r6_comm1 extends r6_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch2
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r6_comm2 extends r6_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch3
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r6_comm3 extends r6_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.switch4
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r7 extends r {}{
  no triggers
  conditions = r7_cond
  commands   = r7_comm
}




abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_state_attr_escalationLevel
  value        = cap_state_attr_escalationLevel_val_2
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
one sig r7_cond2 extends r7_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r7_cond3 extends r7_cond {} {
  capabilities = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_state_attr_escalationLevel
  value        = cap_state_attr_escalationLevel_val - range_0
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_IlluminatedResponsetoUnexpectedVisitors.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



