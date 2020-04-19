module app_ItsTooCold

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_temperatureMeasurement
open cap_switch


one sig app_ItsTooCold extends IoTApp {
  
  temperatureSensor1 : one cap_temperatureMeasurement,
  //temperature1 : one cap_temperatureMeasurement_attr_temperature_val,
  switch1 : one cap_switch,
} {
  rules = r
  //capabilities = temperatureSensor1 + switch1
}


one sig range_0,range_1 extends cap_temperatureMeasurement_attr_temperature_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ItsTooCold.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ItsTooCold.temperatureSensor1
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = range_0//cap_temperatureMeasurement_attr_temperature_val_lte_tooCold
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ItsTooCold.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



