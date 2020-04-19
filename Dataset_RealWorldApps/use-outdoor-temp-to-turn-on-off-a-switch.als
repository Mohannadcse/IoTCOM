module app_use_outdoor_temp_to_turn_on_off_a_switch

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

lone sig app_use_outdoor_temp_to_turn_on_off_a_switch extends IoTApp {
  trigObj : one cap_temperatureMeasurement,
  switch : one cap_switch,
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
  capabilities = app_use_outdoor_temp_to_turn_on_off_a_switch.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_low
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_use_outdoor_temp_to_turn_on_off_a_switch.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



