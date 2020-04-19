module app_SecurityNotificationswithDelay

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_motionSensor
open cap_alarm
open cap_switch
open cap_location

one sig app_SecurityNotificationswithDelay extends IoTApp {
  location : one cap_location,
  
  contacts : some cap_contactSensor,
  
  motions : some cap_motionSensor,
  
  alarms : some cap_alarm,
  
  lights : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contacts + motions + alarms + lights + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_state_attr_triggerMode extends cap_state_attr {} {
  values = cap_state_attr_triggerMode_val
}
abstract sig cap_state_attr_triggerMode_val extends AttrValue {}

one sig cap_state_attr_lastTrigger extends cap_state_attr {} {
  values = cap_state_attr_lastTrigger_val
}
abstract sig cap_state_attr_lastTrigger_val extends AttrValue {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SecurityNotificationswithDelay.contacts
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_SecurityNotificationswithDelay.motions
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SecurityNotificationswithDelay.state
  attribute    = cap_state_attr_triggerMode
  value        = cap_state_attr_triggerMode_val
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_SecurityNotificationswithDelay.state
  attribute    = cap_state_attr_lastTrigger
  value        = cap_state_attr_lastTrigger_val
}
one sig r0_comm2 extends r0_comm {} {
  capability   = app_SecurityNotificationswithDelay.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SecurityNotificationswithDelay.location
  attribute    = cap_location_attr_mode
  value        = cap_state_attr_triggerMode_val
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SecurityNotificationswithDelay.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SecurityNotificationswithDelay.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SecurityNotificationswithDelay.alarms
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_both
}
/*
one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_SecurityNotificationswithDelay.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_SecurityNotificationswithDelay.state
  attribute    = cap_deviceTriggers_attr_deviceTriggers
  value        = cap_deviceTriggers_attr_deviceTriggers_val_not_null
}
*/


