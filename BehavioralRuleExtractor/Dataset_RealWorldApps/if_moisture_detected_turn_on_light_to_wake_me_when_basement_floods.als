module app_if_moisture_detected_turn_on_light_to_wake_me_when_basement_floods

open IoTBottomUp as base

open cap_waterSensor
open cap_switch

one sig app_if_moisture_detected_turn_on_light_to_wake_me_when_basement_floods extends IoTApp {
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
  capabilities = app_if_moisture_detected_turn_on_light_to_wake_me_when_basement_floods.trigObj
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_moisture_detected_turn_on_light_to_wake_me_when_basement_floods.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



