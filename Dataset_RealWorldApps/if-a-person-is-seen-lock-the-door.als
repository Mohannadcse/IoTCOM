module app_if_a_person_is_seen_lock_the_door

open IoTBottomUp as base

open cap_lock
open cap_switch

lone sig app_if_a_person_is_seen_lock_the_door extends IoTApp {
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
  capabilities = app_if_a_person_is_seen_lock_the_door.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_a_person_is_seen_lock_the_door.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



