module app_KeepDoorLocked

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_lock


one sig app_KeepDoorLocked extends IoTApp {
  
  contact : one cap_contactSensor,
  
  locks : set cap_lock,
} {
  rules = r
  //capabilities = contact + locks
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_KeepDoorLocked.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_KeepDoorLocked.locks
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



