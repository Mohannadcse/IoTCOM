module app_unlock-door

open IoTBottomUp as base

open cap_lock

lone sig app_unlock-door extends IoTApp {
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
  capabilities = app_unlock-door.trigObj
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_unlock-door.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlock
}



