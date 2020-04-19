module app_see_if_someone_have_been_snooping_around_in_your_room

open IoTBottomUp as base

open cap_motionSensor
open cap_switch

lone sig app_see_if_someone_have_been_snooping_around_in_your_room extends IoTApp {
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
  capabilities = app_see_if_someone_have_been_snooping_around_in_your_room.trigObj
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_see_if_someone_have_been_snooping_around_in_your_room.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



