module app_wemo_motion_after_60min_turn_all_hue_lights_on_myhue_wemo

open IoTBottomUp as base

open cap_motionSensor
open cap_switch

lone sig app_wemo_motion_after_60min_turn_all_hue_lights_on_myhue_wemo extends IoTApp {
  trigObj : one cap_motionSensor,
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
  capabilities = app_wemo_motion_after_60min_turn_all_hue_lights_on_myhue_wemo.trigObj
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_wemo_motion_after_60min_turn_all_hue_lights_on_myhue_wemo.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



