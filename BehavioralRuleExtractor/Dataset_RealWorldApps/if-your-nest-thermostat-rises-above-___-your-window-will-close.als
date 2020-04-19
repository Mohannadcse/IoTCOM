module app_if_your_nest_thermostat_rises_above_____your_window_will_close

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_lock

lone sig app_if_your_nest_thermostat_rises_above_____your_window_will_close extends IoTApp {
  trigObj : one cap_temperatureMeasurement,
  lock : one cap_lock,
} {
  rules = r
}


// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_if_your_nest_thermostat_rises_above_____your_window_will_close.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_low
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_your_nest_thermostat_rises_above_____your_window_will_close.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



