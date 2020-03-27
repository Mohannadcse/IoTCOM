module app_lock-up-after-me

open IoTBottomUp as base

open cap_presenceSensor
open cap_lock

lone sig app_lock-up-after-me extends IoTApp {
  trigObj : one cap_presenceSensor,
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
  capabilities = app_lock-up-after-me.trigObj
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_lock-up-after-me.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_lock
}



