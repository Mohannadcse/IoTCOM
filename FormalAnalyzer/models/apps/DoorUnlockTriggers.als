module app_DoorUnlockTriggers

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_lock
open cap_doorControl
open cap_switch


one sig app_DoorUnlockTriggers extends IoTApp {
  
  lock1 : one cap_lock,
  
  doors : some cap_doorControl,
  
  switches : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = lock1 + doors + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_nextSunCheck extends cap_state_attr {} {
  values = cap_state_attr_nextSunCheck_val
}

abstract sig cap_state_attr_nextSunCheck_val extends AttrValue {}
one sig cap_state_attr_nextSunCheck_val_ extends cap_state_attr_nextSunCheck_val {}

one sig cap_state_attr_sunsetTime extends cap_state_attr {} {
  values = cap_state_attr_sunsetTime_val
}

abstract sig cap_state_attr_sunsetTime_val extends AttrValue {}
one sig cap_state_attr_sunsetTime_val_ extends cap_state_attr_sunsetTime_val {}

one sig cap_state_attr_sunriseTime extends cap_state_attr {} {
  values = cap_state_attr_sunriseTime_val
}

abstract sig cap_state_attr_sunriseTime_val extends AttrValue {}
one sig cap_state_attr_sunriseTime_val_ extends cap_state_attr_sunriseTime_val {}

one sig cap_now_attr_now_val_gt_noValue extends cap_now_attr_now_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r0_cond extends Condition {}
/*
one sig r0_cond0 extends r0_cond {} {
  capability   = app_DoorUnlockTriggers.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
*/


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DoorUnlockTriggers.switches
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
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r1_cond extends Condition {}
/*
one sig r1_cond0 extends r1_cond {} {
  capability   = app_DoorUnlockTriggers.doors
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_open
}
*/

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DoorUnlockTriggers.doors
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_closed
}


/*
one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DoorUnlockTriggers.now
  attribute    = cap_now_attr_now
  value        = cap_now_attr_now_val_gt_noValue
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DoorUnlockTriggers.state
  attribute    = cap_state_attr_nextSunCheck
  value        = cap_state_attr_nextSunCheck_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_DoorUnlockTriggers.state
  attribute    = cap_sunsetTime_attr_sunsetTime
  value        = cap_sunsetTime_attr_sunsetTime_val
}
one sig r1_comm2 extends r1_comm {} {
  capability   = app_DoorUnlockTriggers.state
  attribute    = cap_sunriseTime_attr_sunriseTime
  value        = cap_sunriseTime_attr_sunriseTime_val
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val - cap_lock_attr_unlocked_val_no_value
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_null
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_DoorUnlockTriggers.doors
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_no_value
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_DoorUnlockTriggers.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_no_value
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_DoorUnlockTriggers.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val - cap_lock_attr_lock_val_null
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_DoorUnlockTriggers.doors
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_no_value
}
one sig r3_comm1 extends r3_comm {} {
  capability   = app_DoorUnlockTriggers.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_no_value
}
*/
