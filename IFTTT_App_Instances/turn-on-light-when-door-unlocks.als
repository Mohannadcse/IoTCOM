module app_turn-on-light-when-door-unlocks

open IoTBottomUp as base

open cap_lock
open cap_switch

lone sig app_turn-on-light-when-door-unlocks extends IoTApp {
  trigObj : one cap_lock,
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
  capabilities = app_turn-on-light-when-door-unlocks.trigObj
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turn-on-light-when-door-unlocks.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



