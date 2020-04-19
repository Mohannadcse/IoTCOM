module app_wemo_a_c_turn_on_at_21c

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

lone sig app_wemo_a_c_turn_on_at_21c extends IoTApp {
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
  capabilities = app_wemo_a_c_turn_on_at_21c.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_low
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_wemo_a_c_turn_on_at_21c.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



