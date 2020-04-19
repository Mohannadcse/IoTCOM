module app_NotifyIfLeftUnlocked

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_userInput
open cap_lock
open cap_contactSensor


one sig app_NotifyIfLeftUnlocked extends IoTApp {
  
  aLock : one cap_lock,
  
  openSensor : one cap_contactSensor,
  lockIfClosed : one cap_userInput,
  state : one cap_state,
} {
  rules = r
  //capabilities = aLock + openSensor + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_retries extends cap_state_attr {} {
  values = cap_state_attr_retries_val
}

abstract sig cap_state_attr_retries_val extends AttrValue {}
one sig cap_state_attr_retries_val_0 extends cap_state_attr_retries_val {}

//one sig cap_userInput_attr_lockIfClosed extends cap_userInput_attr {} {
//  values = cap_userInput_attr_lockIfClosed_val
//}

//abstract sig cap_userInput_attr_lockIfClosed_val extends extends cap_userInput_attr_value_val {}
//one sig cap_userInput_attr_lockIfClosed_val_true, cap_userInput_attr_lockIfClosed_val_false extends cap_userInput_attr_lockIfClosed_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_NotifyIfLeftUnlocked.lockIfClosed
  attribute    = cap_userInput_attr //cap_user_attr_lockIfClosed
  value        = cap_userInput_attr_value_boolval_true //cap_userInput_attr_lockIfClosed_val_true
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_NotifyIfLeftUnlocked.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_NotifyIfLeftUnlocked.aLock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_NotifyIfLeftUnlocked.aLock
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_NotifyIfLeftUnlocked.aLock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val - cap_lock_attr_lock_val_locked
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_NotifyIfLeftUnlocked.state
  attribute    = cap_state_attr_retries
  value        = cap_state_attr_retries_val_0
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_NotifyIfLeftUnlocked.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_NotifyIfLeftUnlocked.lockIfClosed
  attribute    = cap_userInput_attr //cap_user_attr_lockIfClosed
  value        = cap_userInput_attr_value_boolval_true //cap_user_attr_lockIfClosed_val_no_value
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_NotifyIfLeftUnlocked.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_NotifyIfLeftUnlocked.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



