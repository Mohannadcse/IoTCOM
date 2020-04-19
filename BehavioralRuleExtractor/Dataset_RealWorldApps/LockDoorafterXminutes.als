module app_LockDoorafterXminutes

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_lock


one sig app_LockDoorafterXminutes extends IoTApp {
  
  whichLock : one cap_lock,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = whichLock + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_scheduled extends cap_state_attr {} {
  values = cap_state_attr_scheduled_val
}

abstract sig cap_state_attr_scheduled_val extends AttrValue {}
one sig cap_state_attr_scheduled_val_false extends cap_state_attr_scheduled_val {}
one sig cap_state_attr_scheduled_val_true extends cap_state_attr_scheduled_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LockDoorafterXminutes.whichLock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LockDoorafterXminutes.state
  attribute    = cap_state_attr_scheduled
  value        = cap_state_attr_scheduled_val_true
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_LockDoorafterXminutes.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LockDoorafterXminutes.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LockDoorafterXminutes.whichLock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_LockDoorafterXminutes.state
  attribute    = cap_state_attr_scheduled
  value        = cap_state_attr_scheduled_val_false
}



