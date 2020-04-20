module app_ID3SmokeAlarm

open IoTBottomUp as base

open cap_alarm
open cap_runIn
open cap_smokeDetector


one sig app_ID3SmokeAlarm extends IoTApp {
  
  smoke : one cap_smokeDetector,
  
  runIn : one cap_state,
  
  state : one cap_state,
  
  alarm : one cap_alarm,
} {
  rules = r
}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}


one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_msg extends cap_state_attr {} {
  values = cap_state_attr_msg_val
}

abstract sig cap_state_attr_msg_val extends AttrValue {}
one sig cap_state_attr_msg_val_smoke_detected extends cap_state_attr_msg_val {}

one sig cap_state_attr_fake extends cap_state_attr {} {
  values = cap_state_attr_fake_val
}

abstract sig cap_state_attr_fake_val extends AttrValue {}
one sig cap_state_attr_fake_val_true extends cap_state_attr_fake_val {}





// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID3SmokeAlarm.smoke
  attribute    = cap_smokeDetector_attr_smoke
  no value
}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID3SmokeAlarm.alarm
  attribute = cap_alarm_attr_alarm
  value = cap_alarm_attr_alarm_val_strobe
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID3SmokeAlarm.smoke
  attribute    = cap_smokeDetector_attr_smoke
  no value
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID3SmokeAlarm.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}



