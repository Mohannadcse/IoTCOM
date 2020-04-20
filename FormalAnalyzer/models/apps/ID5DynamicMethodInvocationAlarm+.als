module app_ID5DynamicMethodInvocationAlarm

open IoTBottomUp as base

open cap_smokeDetector
open cap_alarm


one sig app_ID5DynamicMethodInvocationAlarm extends IoTApp {
  
  smoke : one cap_smokeDetector,
  
  alarm : one cap_alarm,
  
  state : one cap_state,
} {
  rules = r
}


one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_method extends cap_state_attr {} {
  values = cap_state_attr_method_val
}

abstract sig cap_state_attr_method_val extends AttrValue {}
one sig cap_state_attr_method_val_ extends cap_state_attr_method_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID5DynamicMethodInvocationAlarm.smoke
  attribute    = cap_smokeDetector_attr_smoke
  no value
  //value        = cap_smokeDetector_attr_smoke_val
}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID5DynamicMethodInvocationAlarm.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_strobe
}



