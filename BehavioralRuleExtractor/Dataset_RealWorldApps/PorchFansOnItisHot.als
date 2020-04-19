module app_PorchFansOnItisHot

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_temperatureMeasurement
open cap_switch


one sig app_PorchFansOnItisHot extends IoTApp {
  
  motion1 : one cap_motionSensor,
  
  sensor1 : one cap_temperatureMeasurement,
  
  switches : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = motion1 + sensor1 + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_inactiveAt extends cap_state_attr {} {
  values = cap_state_attr_inactiveAt_val
}

abstract sig cap_state_attr_inactiveAt_val extends AttrValue {}
one sig cap_state_attr_inactiveAt_val_null extends cap_state_attr_inactiveAt_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_PorchFansOnItisHot.motion1
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_PorchFansOnItisHot.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_PorchFansOnItisHot.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_PorchFansOnItisHot.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_PorchFansOnItisHot.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val - cap_state_attr_inactiveAt_val_null
}
/*
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_PorchFansOnItisHot.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val_no_value
}
*/
abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_PorchFansOnItisHot.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_PorchFansOnItisHot.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val_null
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_PorchFansOnItisHot.motion1
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_PorchFansOnItisHot.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_PorchFansOnItisHot.sensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_PorchFansOnItisHot.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_PorchFansOnItisHot.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val_null
}



