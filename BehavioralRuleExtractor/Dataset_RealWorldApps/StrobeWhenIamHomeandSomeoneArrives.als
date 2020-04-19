module app_StrobeWhenIamHomeandSomeoneArrives

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_presenceSensor
open cap_alarm


one sig app_StrobeWhenIamHomeandSomeoneArrives extends IoTApp {
  
  presence1 : one cap_presenceSensor,
  
  presence2 : one cap_presenceSensor,
  
  alarm : one cap_alarm,
} {
  rules = r
  //capabilities = presence1 + presence2 + alarm
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_StrobeWhenIamHomeandSomeoneArrives.presence2
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_StrobeWhenIamHomeandSomeoneArrives.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_strobe
}



