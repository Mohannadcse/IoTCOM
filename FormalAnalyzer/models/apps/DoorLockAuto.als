module app_DoorLockAuto

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_lock


one sig app_DoorLockAuto extends IoTApp {
  
  lock1 : one cap_lock,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = lock1 + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_DoorLockAuto.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_DoorLockAuto.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_DoorLockAuto.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val - cap_lock_attr_lock_val_locked
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DoorLockAuto.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



