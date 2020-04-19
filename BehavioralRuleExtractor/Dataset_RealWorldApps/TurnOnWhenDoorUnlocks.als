module app_TurnOnWhenDoorUnlocks

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_lock
open cap_switch
open cap_location
open cap_userInput

one sig app_TurnOnWhenDoorUnlocks extends IoTApp {
  location : one cap_location,
  
  lock1 : some cap_lock,
  
  switches : some cap_switch,
  
  turnoff : one cap_userInput,
  
  turnon : one cap_userInput,
  
  startTime : one cap_userInput,
  turnoffdelay : one cap_userInput,
  state : one cap_state,
} {
  rules = r
  //capabilities = lock1 + switches + turnoff + turnon + startTime + state
}

abstract sig cap_userInput_attr_turnoff_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_turnoff_val_yes extends cap_userInput_attr_turnoff_val {}
one sig cap_userInput_attr_turnoff_val_no extends cap_userInput_attr_turnoff_val {}
abstract sig cap_userInput_attr_turnon_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_turnon_val_yes extends cap_userInput_attr_turnon_val {}
one sig cap_userInput_attr_turnon_val_no extends cap_userInput_attr_turnon_val {}
abstract sig cap_userInput_attr_startTime_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_startTime_val_0 extends cap_userInput_attr_startTime_val {}

abstract sig cap_userInput_attr_turnoffdelay_val extends cap_userInput_attr_value_val {}

one sig cap_userInput_attr_turnoffdelay extends cap_userInput_attr {}
{
    values = cap_userInput_attr_turnoffdelay_val
} 

one sig cap_userInput_attr_turnoff extends cap_userInput_attr {}
{
    values = cap_userInput_attr_turnoff_val
} 

one sig cap_userInput_attr_turnon extends cap_userInput_attr {}
{
    values = cap_userInput_attr_turnon_val
} 

one sig cap_userInput_attr_startTime extends cap_userInput_attr {}
{
    values = cap_userInput_attr_startTime_val
} 

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}

one sig cap_location_attr_mode_val_newMode extends cap_location_attr_mode_val {}{}

abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoff
  attribute    = cap_userInput_attr_turnoff
  value        = cap_userInput_attr_turnoff_val_yes
}

one sig r0_cond1 extends r0_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoffdelay
  attribute    = cap_userInput_attr_turnoffdelay
  value        = cap_userInput_attr_turnoffdelay_val
}

one sig r0_cond2 extends r0_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r0_cond3 extends r0_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.startTime
  attribute    = cap_userInput_attr_startTime
  value        = cap_userInput_attr_startTime_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.state
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
  capabilities = app_TurnOnWhenDoorUnlocks.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
/*
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.user
  attribute    = cap_userInput_attr_turnon
  value        = cap_userInput_attr_turnon_val_
}
*/
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - cap_location_attr_mode_val_newMode
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_newMode
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnon
  attribute    = cap_userInput_attr_turnon
  value        = cap_userInput_attr_turnon_val_yes
}
/*
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.user
  attribute    = cap_userInput_attr_startTime
  value        = cap_userInput_attr_startTime_val_
}
*/

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
/*
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.user
  attribute    = cap_userInput_attr_turnon
  value        = cap_userInput_attr_turnon_val_
}
one sig r4_cond2 extends r4_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.user
  attribute    = cap_userInput_attr_startTime
  value        = cap_userInput_attr_startTime_val_
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
*/
one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoff
  attribute    = cap_userInput_attr_turnoff
  value        = cap_userInput_attr_turnoff_val_yes
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoffdelay
  attribute    = cap_userInput_attr_turnoffdelay
  value        = cap_userInput_attr_turnoffdelay_val
}
one sig r5_cond2 extends r5_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r6_cond extends Condition {}
/*
one sig r6_cond0 extends r6_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoff
  attribute    = cap_userInput_attr_turnoff
  value        = cap_userInput_attr_turnoff_val
}
*/
one sig r6_cond1 extends r6_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r6_cond2 extends r6_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - cap_location_attr_mode_val_newMode
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_newMode
}
/*
one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  no value
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.turnoff
  attribute    = cap_userInput_attr_turnoff
  value        = cap_userInput_attr_turnoff_val
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.user
  attribute    = cap_userInput_attr_turnoffdelay
  value        = cap_userInput_attr_turnoffdelay_val_no_value
}
one sig r7_cond2 extends r7_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r7_cond3 extends r7_cond {} {
  capabilities = app_TurnOnWhenDoorUnlocks.startTime
  attribute    = cap_userInput_attr_startTime
  value        = cap_userInput_attr_startTime_val
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_TurnOnWhenDoorUnlocks.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
*/


