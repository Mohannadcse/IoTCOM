module app_turn_off_the_fireplace

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

one sig app_turn_off_the_fireplace extends IoTApp {
  trigObj : one cap_temperatureMeasurement,
  switch : one cap_switch,
} {
  rules = r
}

one sig range_0, range_1 extends cap_temperatureMeasurement_attr_temperature_val {}

// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_turn_off_the_fireplace.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = range_1
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turn_off_the_fireplace.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



