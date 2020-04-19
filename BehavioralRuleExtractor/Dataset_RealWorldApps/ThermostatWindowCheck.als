module app_ThermostatWindowCheck

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_thermostatMode
open cap_contactSensor
open cap_thermostat

open cap_userInput

one sig app_ThermostatWindowCheck extends IoTApp {
  
  sensors : some cap_contactSensor,
  thrMode : some cap_thermostatMode,
  thermostats : some cap_thermostatMode,
  runIn : one cap_state,
  sendPushMessage : one cap_userInput,
  
  turnOffTherm : one cap_userInput,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = sensors + thermostats + sendPushMessage + turnOffTherm + state
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}
abstract sig cap_userInput_attr_turnOffTherm_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_turnOffTherm_val_Yes extends cap_userInput_attr_turnOffTherm_val {}
one sig cap_userInput_attr_turnOffTherm_val_No extends cap_userInput_attr_turnOffTherm_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ThermostatWindowCheck.thermostats
  attribute    = cap_thermostatMode_attr_thermostatMode
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ThermostatWindowCheck.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ThermostatWindowCheck.thermostats
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_heat
}
/*
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_ThermostatWindowCheck.user
  attribute    = cap_user_attr_turnOffTherm
  value        = cap_user_attr_turnOffTherm_val_Yes
}
*/
one sig r0_cond3 extends r0_cond {} {
  capabilities = app_ThermostatWindowCheck.thermostats
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_cool
}

abstract sig r0_comm extends Command {}
/*
one sig r0_comm0 extends r0_comm {} {
  capability   = app_ThermostatWindowCheck.state
  attribute    = cap_turnOffTime_attr_turnOffTime
  value        = cap_turnOffTime_attr_turnOffTime_val_not_null
}
*/
one sig r0_comm1 extends r0_comm {} {
  capability   = app_ThermostatWindowCheck.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions //= r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ThermostatWindowCheck.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

/*
abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ThermostatWindowCheck.user
  attribute    = cap_user_attr_turnOffTherm
  value        = cap_user_attr_turnOffTherm_val_Yes
}
*/
abstract sig r1_comm extends Command {}
/*
one sig r1_comm0 extends r1_comm {} {
  capability   = app_ThermostatWindowCheck.state
  attribute    = cap_turnOffTime_attr_turnOffTime
  value        = cap_turnOffTime_attr_turnOffTime_val_not_null
}
*/
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ThermostatWindowCheck.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ThermostatWindowCheck.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ThermostatWindowCheck.thermostats
  attribute    = cap_thermostatMode_attr_thermostatMode
  value        = cap_thermostatMode_attr_thermostatMode_val_off
}



