module app_if_the_room_is_warm_switch_on_the_bedlight

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

lone sig app_if_the_room_is_warm_switch_on_the_bedlight extends IoTApp {
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
  capabilities = app_if_the_room_is_warm_switch_on_the_bedlight.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_low
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_the_room_is_warm_switch_on_the_bedlight.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



