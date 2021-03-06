module app_motion_at_my_house_detected

open IoTBottomUp as base

open cap_motionSensor
open cap_switch

lone sig app_motion_at_my_house_detected extends IoTApp {
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
  capabilities = app_motion_at_my_house_detected.trigObj
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_motion_at_my_house_detected.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



