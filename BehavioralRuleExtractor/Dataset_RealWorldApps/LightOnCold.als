module app_LightOnCold

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_userInput
open cap_temperatureMeasurement
open cap_switch


one sig app_LightOnCold extends IoTApp {
  
  temperatureSensor1 : one cap_temperatureMeasurement,
  temperature1 : one cap_userInput,
  switch1 : one cap_switch,
} {
  rules = r
  //capabilities = temperatureSensor1 + switch1 + temperature1
}


one sig cap_userInput_attr_temperature1 extends cap_userInput_attr {}
{
    values = cap_userInput_attr_temperature1_val
} 


abstract sig cap_userInput_attr_temperature1_val extends cap_userInput_attr_value_val {}
one sig range_0,range_1 extends cap_userInput_attr_temperature1_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LightOnCold.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LightOnCold.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  //value        = cap_temperatureMeasurement_attr_temperature_val_lte_tooCold
  value       = range_0
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LightOnCold.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



