module app_run_fan_if_moisture_level_is_too_high

open IoTBottomUp as base

open cap_waterSensor
open cap_switch

lone sig app_run_fan_if_moisture_level_is_too_high extends IoTApp {
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
  capabilities = app_run_fan_if_moisture_level_is_too_high.trigObj
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_run_fan_if_moisture_level_is_too_high.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



