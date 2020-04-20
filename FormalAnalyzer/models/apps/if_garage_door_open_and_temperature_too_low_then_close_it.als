module app_if_garage_door_open_and_temperature_too_low_then_close_it

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

one sig app_if_garage_door_open_and_temperature_too_low_then_close_it extends IoTApp {
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
  capabilities = app_if_garage_door_open_and_temperature_too_low_then_close_it.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = range_0
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_garage_door_open_and_temperature_too_low_then_close_it.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



