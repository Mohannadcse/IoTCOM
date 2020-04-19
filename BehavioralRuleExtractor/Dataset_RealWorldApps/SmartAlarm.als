module app_SmartAlarm

open IoTBottomUp as base

open cap_motionSensor
open cap_location
open cap_imageCapture
open cap_contactSensor
open cap_waterSensor
open cap_smokeDetector


one sig app_SmartAlarm extends IoTApp {
  
  zn_contact : some cap_contactSensor,
  
  zn_motion : some cap_motionSensor,
  
  zn_water : some cap_waterSensor,
  
  no_value : one cap_location_attr_mode_val,
  
  state : one cap_state,
  
  location : one cap_location,
  
  zn_camera : some cap_imageCapture,
  
  zn_smoke : some cap_smokeDetector,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_alarm extends cap_state_attr {} {
  values = cap_state_attr_alarm_val
}

abstract sig cap_state_attr_alarm_val extends AttrValue {}
one sig cap_state_attr_alarm_val_true extends cap_state_attr_alarm_val {}
one sig cap_state_attr_alarm_val_false extends cap_state_attr_alarm_val {}

one sig cap_state_attr_installed extends cap_state_attr {} {
  values = cap_state_attr_installed_val
}

abstract sig cap_state_attr_installed_val extends AttrValue {}
one sig cap_state_attr_installed_val_true extends cap_state_attr_installed_val {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}

one sig cap_state_attr_armed extends cap_state_attr {} {
  values = cap_state_attr_armed_val
}

abstract sig cap_state_attr_armed_val extends AttrValue {}
one sig cap_state_attr_armed_val_true extends cap_state_attr_armed_val {}
one sig cap_state_attr_armed_val_false extends cap_state_attr_armed_val {}

one sig cap_state_attr_stay extends cap_state_attr {} {
  values = cap_state_attr_stay_val
}

abstract sig cap_state_attr_stay_val extends AttrValue {}
one sig cap_state_attr_stay_val_true extends cap_state_attr_stay_val {}
one sig cap_state_attr_stay_val_false extends cap_state_attr_stay_val {}


one sig cap_state_attr_exitDelay extends cap_state_attr {} {
  values = cap_state_attr_exitDelay_val
}
abstract sig cap_state_attr_exitDelay_val extends AttrValue {}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SmartAlarm.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartAlarm.state
  attribute = cap_state_attr_alarm
  value = cap_state_attr_alarm_val_false
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SmartAlarm.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SmartAlarm.state
  attribute    = cap_state_attr_exitDelay
  value        = cap_state_attr_exitDelay_val
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SmartAlarm.state
  attribute = cap_state_attr_armed
  value = cap_state_attr_armed_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SmartAlarm.state
  attribute = cap_state_attr_stay
  value = cap_state_attr_stay_val
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_SmartAlarm.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_SmartAlarm.state
  attribute    = cap_state_attr_exitDelay
  value        = cap_state_attr_exitDelay_val
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_SmartAlarm.state
  attribute = cap_state_attr_alarm
  value = cap_state_attr_alarm_val_false
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_SmartAlarm.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_SmartAlarm.state
  attribute    = cap_state_attr_exitDelay
  value        = cap_state_attr_exitDelay_val
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_SmartAlarm.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



