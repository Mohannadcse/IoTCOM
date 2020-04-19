module app_if_humidity_is_too_high_turn_on_fan

open IoTBottomUp as base

open cap_waterSensor
open cap_switch

lone sig app_if_humidity_is_too_high_turn_on_fan extends IoTApp {
  trigObj : one cap_waterSensor,
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
  capabilities = app_if_humidity_is_too_high_turn_on_fan.trigObj
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_humidity_is_too_high_turn_on_fan.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



