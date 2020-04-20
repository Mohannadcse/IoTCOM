module app_ID6TurnOnSwitchNotHome

open IoTBottomUp as base

open cap_switchLevel
open cap_lock
open cap_runIn
open cap_presenceSensor
open cap_alarm


one sig app_ID6TurnOnSwitchNotHome extends IoTApp {
  
  runIn : one cap_state,
  
  myswitch : one cap_switchLevel,
  
  state : one cap_state,
  
  thelock : one cap_lock,
  
  person : one cap_presenceSensor,
} {
  rules = r
}



one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_attack extends cap_state_attr {} {
  values = cap_state_attr_attack_val
}

abstract sig cap_state_attr_attack_val extends AttrValue {}
one sig cap_state_attr_attack_val_true extends cap_state_attr_attack_val {}
one sig cap_state_attr_attack_val_false extends cap_state_attr_attack_val {}

one sig cap_state_attr_home extends cap_state_attr {} {
  values = cap_state_attr_home_val
}

abstract sig cap_state_attr_home_val extends AttrValue {}
one sig cap_state_attr_home_val_false extends cap_state_attr_home_val {}
one sig cap_state_attr_home_val_true extends cap_state_attr_home_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID6TurnOnSwitchNotHome.person
  attribute    = cap_presenceSensor_attr_presence
  no value   //= cap_presenceSensor_attr_presence_val_not_present
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID6TurnOnSwitchNotHome.person
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.state
  attribute = cap_state_attr_home
  value = cap_state_attr_home_val_false
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.state
  attribute = cap_state_attr_attack
  value = cap_state_attr_attack_val_true
}
one sig r0_comm2 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.myswitch
  attribute = cap_switchLevel_attr_level
  value = cap_switchLevel_attr_level_val
}
one sig r0_comm3 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.thelock
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_locked
}
one sig r0_comm4 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}
/*
one sig r0_comm5 extends r0_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}
*/
one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID6TurnOnSwitchNotHome.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.thelock
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
  capabilities = app_ID6TurnOnSwitchNotHome.person
  attribute    = cap_presenceSensor_attr_presence
  no value        //= cap_presenceSensor_attr_presence_val
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID6TurnOnSwitchNotHome.person
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.myswitch
  attribute = cap_switchLevel_attr_level
  //value = cap_switchLevel_attr_level_val // leave this underspecified, let alloy do it
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.state
  attribute = cap_state_attr_home
  value = cap_state_attr_home_val_true
}
one sig r2_comm2 extends r2_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.state
  attribute = cap_state_attr_attack
  value = cap_state_attr_attack_val_false
}


one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ID6TurnOnSwitchNotHome.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ID6TurnOnSwitchNotHome.myswitch
  attribute = cap_switchLevel_attr_level
  //value = cap_switchLevel_attr_level_val // underspecified
}

