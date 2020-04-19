module app_LockItWhenItCloses

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_lock


one sig app_LockItWhenItCloses extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  lock1 : some cap_lock,
} {
  rules = r
  //capabilities = contact1 + lock1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LockItWhenItCloses.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LockItWhenItCloses.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LockItWhenItCloses.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



