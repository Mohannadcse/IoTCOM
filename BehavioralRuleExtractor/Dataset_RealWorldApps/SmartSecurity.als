module app_SmartSecurity

open IoTBottomUp as base

open cap_motionSensor
open cap_alarm
open cap_switch
open cap_contactSensor


one sig app_SmartSecurity extends IoTApp {
  
  intrusionContacts : some cap_contactSensor,
  
  residentMotions : some cap_motionSensor,
  
  state : one cap_state,
  
  alarms : some cap_alarm,
  
  intrusionMotions : some cap_motionSensor,
  
  lights : some cap_switch,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}

one sig cap_state_attr_alarmActive extends cap_state_attr {} {
  values = cap_state_attr_alarmActive_val
}

abstract sig cap_state_attr_alarmActive_val extends AttrValue {}
one sig cap_state_attr_alarmActive_val_null extends cap_state_attr_alarmActive_val {}
one sig cap_state_attr_alarmActive_val_true extends cap_state_attr_alarmActive_val {}
one sig cap_state_attr_alarmActive_val_false extends cap_state_attr_alarmActive_val {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}

one sig cap_state_attr_lastIntruderMotion extends cap_state_attr {} {
  values = cap_state_attr_lastIntruderMotion_val
}

abstract sig cap_state_attr_lastIntruderMotion_val extends AttrValue {}
one sig cap_state_attr_lastIntruderMotion_val_null extends cap_state_attr_lastIntruderMotion_val {}

one sig cap_state_attr_residentsAreUp extends cap_state_attr {} {
  values = cap_state_attr_residentsAreUp_val
}

abstract sig cap_state_attr_residentsAreUp_val extends AttrValue {}
one sig cap_state_attr_residentsAreUp_val_true extends cap_state_attr_residentsAreUp_val {}
one sig cap_state_attr_residentsAreUp_val_null extends cap_state_attr_residentsAreUp_val {}
one sig cap_state_attr_residentsAreUp_val_false extends cap_state_attr_residentsAreUp_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartSecurity.state
  attribute = cap_state_attr_residentsAreUp
  value = cap_state_attr_residentsAreUp_val_false
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SmartSecurity.state
  attribute    = cap_state_attr_alarmActive
  value        = cap_state_attr_alarmActive_val
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SmartSecurity.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SmartSecurity.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



