module app_ItsTooHot

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_temperatureMeasurement
open cap_switch
open cap_userInput


one sig app_ItsTooHot extends IoTApp {
  
  temperatureSensor1 : one cap_temperatureMeasurement,
  
  switch1 : one cap_switch,
  
  sendPushMessage : one cap_userInput,
} {
  rules = r
  //capabilities = temperatureSensor1 + switch1 + sendPushMessage
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}


one sig range_0,range_1 extends cap_temperatureMeasurement_attr_temperature_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ItsTooHot.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ItsTooHot.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = range_1//cap_temperatureMeasurement_attr_temperature_val_gte_tooHot
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ItsTooHot.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



