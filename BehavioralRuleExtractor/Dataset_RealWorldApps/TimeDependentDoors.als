module app_TimeDependentDoors

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_lock
open cap_switch
open cap_lock


one sig app_TimeDependentDoors extends IoTApp {
  
  person : one cap_presenceSensor,
  
  nightdoor : one cap_lock,
  
  nightlights : some cap_switch,
  
  daydoor : one cap_lock,
} {
  rules = r
  //capabilities = person + nightdoor + nightlights + daydoor
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_TimeDependentDoors.person
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_TimeDependentDoors.person
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TimeDependentDoors.nightdoor
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_TimeDependentDoors.nightlights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_TimeDependentDoors.person
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_TimeDependentDoors.person
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_TimeDependentDoors.daydoor
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}



