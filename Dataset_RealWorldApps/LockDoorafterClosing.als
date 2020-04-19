module app_LockDoorafterClosing

open IoTBottomUp as base

open cap_lock
open cap_contactSensor


one sig app_LockDoorafterClosing extends IoTApp {
  
  contact : lone cap_contactSensor,
  
  lock1 : lone cap_lock,
  
  state : one cap_state,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r0_trig2 extends r0_trig {} {
  capabilities = app_LockDoorafterClosing.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r0_trig3 extends r0_trig {} {
  capabilities = app_LockDoorafterClosing.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

one sig r0_cond2 extends r0_cond {} {
  capabilities = app_LockDoorafterClosing.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LockDoorafterClosing.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LockDoorafterClosing.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LockDoorafterClosing.lock1
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_unlocked
}



one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r2_trig1 extends r2_trig {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r2_trig2 extends r2_trig {} {
  capabilities = app_LockDoorafterClosing.lock1
  attribute    = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_unlocked
}
one sig r2_trig3 extends r2_trig {} {
  capabilities = app_LockDoorafterClosing.lock1
  attribute    = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_locked
}


abstract sig r2_cond extends Condition {}

one sig r2_cond2 extends r2_cond {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

one sig r2_cond4 extends r2_cond {} {
  capabilities = app_LockDoorafterClosing.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_lock_attr_lock_val_unlocked
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_LockDoorafterClosing.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}


one sig r4 extends r {}{
  no triggers
  conditions = r4_cond
  commands   = r4_comm
}




abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_LockDoorafterClosing.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_LockDoorafterClosing.lock1
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_locked
}



