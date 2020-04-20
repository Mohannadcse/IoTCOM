module app_turn_on_wemo_switch_after_1_hour_of_non_movement

open IoTBottomUp as base

open cap_motionSensor
open cap_switch

lone sig app_turn_on_wemo_switch_after_1_hour_of_non_movement extends IoTApp {
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
  capabilities = app_turn_on_wemo_switch_after_1_hour_of_non_movement.trigObj
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turn_on_wemo_switch_after_1_hour_of_non_movement.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



