module app_unlock_my_house_door_when_i_get_home_and_turn_off_the_car

open IoTBottomUp as base

open cap_lock
open cap_switch

lone sig app_unlock_my_house_door_when_i_get_home_and_turn_off_the_car extends IoTApp {
  trigObj : one cap_switch,
  lock : one cap_lock,
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
  capabilities = app_unlock_my_house_door_when_i_get_home_and_turn_off_the_car.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_unlock_my_house_door_when_i_get_home_and_turn_off_the_car.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}



