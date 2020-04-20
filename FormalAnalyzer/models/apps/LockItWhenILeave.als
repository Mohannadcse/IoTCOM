module app_LockItWhenILeave

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_lock
open cap_userInput

one sig app_LockItWhenILeave extends IoTApp {
  
  presence1 : some cap_presenceSensor,
  
  lock1 : some cap_lock,
  
  unlock : one cap_userInput,
} {
  rules = r
  //capabilities = presence1 + lock1 + unlock
}

one sig cap_userInput_attr_unlock extends cap_userInput_attr {}
{
    values = cap_userInput_attr_unlock_val
} 

abstract sig cap_userInput_attr_unlock_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_unlock_val_Yes extends cap_userInput_attr_unlock_val {}
one sig cap_userInput_attr_unlock_val_No extends cap_userInput_attr_unlock_val {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LockItWhenILeave.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LockItWhenILeave.unlock
  attribute    = cap_userInput_attr_unlock
  value        = cap_userInput_attr_unlock_val_Yes
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_LockItWhenILeave.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LockItWhenILeave.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_LockItWhenILeave.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LockItWhenILeave.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}
/*
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_LockItWhenILeave.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_null
}
*/

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LockItWhenILeave.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}



