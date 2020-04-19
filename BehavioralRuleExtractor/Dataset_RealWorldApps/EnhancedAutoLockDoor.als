module app_EnhancedAutoLockDoor

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_lock
open cap_contactSensor


one sig app_EnhancedAutoLockDoor extends IoTApp {
  
  lock1 : one cap_lock,
  
  contact : one cap_contactSensor,
  
  state : one cap_state,
} {
  rules = r
  ////capabilities = lock1 + contact + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}
/*
one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r0_trig2 extends r0_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock_val_unlocked
  no value
}
one sig r0_trig3 extends r0_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_closed
}
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}

one sig r0_cond3 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val - cap_lock_attr_lock_val_unlocked
}

one sig r0_cond4 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_unlocked
}

one sig r0_cond5 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r0_cond6 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}

one sig r0_cond7 extends r0_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_locked
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_EnhancedAutoLockDoor.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
*/
one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_EnhancedAutoLockDoor.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r2_trig1 extends r2_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r2_trig2 extends r2_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r2_trig3 extends r2_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}


abstract sig r2_cond extends Condition {}
/*
one sig r2_cond0 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_closed
}
one sig r2_cond3 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_lock_attr_lock_val - cap_lock_attr_lock_val_unlocked
}
one sig r2_cond4 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_locked
}
*/
one sig r2_cond5 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r2_cond6 extends r2_cond {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_EnhancedAutoLockDoor.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r3_trig1 extends r3_trig {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r3_trig2 extends r3_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r3_trig3 extends r3_trig {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_EnhancedAutoLockDoor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_EnhancedAutoLockDoor.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r4 extends r {}{
  no triggers
  conditions = r4_cond
  commands   = r4_comm
}




abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_EnhancedAutoLockDoor.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_EnhancedAutoLockDoor.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



