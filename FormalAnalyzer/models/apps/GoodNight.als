module app_GoodNight

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_motionSensor
open cap_switch
open cap_location

one sig app_GoodNight extends IoTApp {
  location : one cap_location,
  motionSensors : some cap_motionSensor,
  switches : some cap_switch,
  state : one cap_state,
  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = motionSensors + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_state_attr_motionStoppedAt extends cap_state_attr {} {
  values = cap_state_attr_motionStoppedAt_val
}

abstract sig cap_state_attr_motionStoppedAt_val extends AttrValue {}
one sig cap_state_attr_motionStoppedAt_val_null, cap_state_attr_motionStoppedAt_val_not_null extends cap_state_attr_motionStoppedAt_val {}

one sig cap_now_attr_now_val_lte_startTime, cap_now_attr_now_val_gt_startTime extends cap_now_attr_now_val {}

one sig trig0 extends Trigger {} {
  capabilities = app_GoodNight.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig trig1 extends Trigger {} {
  capabilities = app_GoodNight.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}

one sig trig2 extends Trigger {} {
  capabilities = app_GoodNight.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}

one sig cond0 extends Condition {} {
  capabilities = app_GoodNight.state
  attribute    = cap_state_attr_motionStoppedAt
  value        = cap_state_attr_motionStoppedAt_val_not_null
}

one sig cond1 extends Condition {} {
  capabilities = app_GoodNight.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig cond2 extends Condition {} {
  capabilities = app_GoodNight.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_GoodNight.newMode
}

one sig cond3 extends Condition {} {
  capabilities = cap_now
  attribute    = cap_now_attr_now
  value        = cap_now_attr_now_val_gt_startTime
}

one sig cond4 extends Condition {} {
  capabilities = app_GoodNight.motionSensors
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}

one sig comm0 extends Command {} {
  capability   = app_GoodNight.state
  attribute    = cap_state_attr_motionStoppedAt
  value        = cap_state_attr_motionStoppedAt_val_null
}

one sig comm1 extends Command {} {
  capability   = app_GoodNight.location
  attribute    = cap_location_attr_mode
  value        = app_GoodNight.newMode
}

one sig comm2 extends Command {} {
  capability   = app_GoodNight.state
  attribute    = cap_state_attr_motionStoppedAt
  value        = cap_state_attr_motionStoppedAt_val_not_null
}

abstract sig r extends Rule {}

one sig r0 extends r {} {
  triggers     = trig0
  conditions   = cond0 + cond1
  commands     = comm0
}

one sig r1 extends r {} {
  triggers     = trig0
  conditions   = cond0 + cond1 + cond2
  commands     = comm1
}

one sig r2 extends r {} {
  triggers     = trig1
  conditions   = cond0
  commands     = comm0
}

one sig r3 extends r {} {
  triggers     = trig2
  conditions   = cond3 + cond4 + cond2
  commands     = comm2
}

one sig r4 extends r {} {
  no triggers
  conditions   = cond0 + cond1
  commands     = comm0
}

one sig r5 extends r {} {
  no triggers
  conditions   = cond0 + cond1 + cond2
  commands     = comm1
}

