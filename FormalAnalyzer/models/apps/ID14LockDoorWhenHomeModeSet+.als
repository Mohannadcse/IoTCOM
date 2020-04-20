module app_ID14LockDoorWhenHomeModeSet

open IoTBottomUp as base

open cap_location
open cap_lock


one sig app_ID14LockDoorWhenHomeModeSet extends IoTApp {
  
  lock : one cap_lock,
  
  state : one cap_state,
  
  location : one cap_location,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_home extends cap_state_attr {} {
  values = cap_state_attr_home_val
}

abstract sig cap_state_attr_home_val extends AttrValue {}
one sig cap_state_attr_home_val_true extends cap_state_attr_home_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  no conditions
  commands   = r0_comm
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID14LockDoorWhenHomeModeSet.state
  attribute = cap_state_attr_home
  value = cap_state_attr_home_val_true
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_ID14LockDoorWhenHomeModeSet.lock
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_locked
}



