module app_LittleLight

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_location

one sig app_LittleLight extends IoTApp {
  location : one cap_location,
  
  switch1 : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = switch1 + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_state_attr_riseTime extends cap_state_attr {} {
  values = cap_state_attr_riseTime_val
}

abstract sig cap_state_attr_riseTime_val extends AttrValue {}

one sig cap_now_attr_now_val_gte_noValue extends cap_now_attr_now_val {}
one sig cap_now_attr_now_val_lte_noValue extends cap_now_attr_now_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val 
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r1_cond extends Condition {}
/*
one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime.time
}



one sig r1_comm0 extends r1_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_setTime_attr_setTime
  value        = cap_setTime_attr_setTime_val_not_null
}
*/
abstract sig r1_comm extends Command {}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_LittleLight.user
  attribute    = cap_user_attr_offAtRise
  value        = cap_user_attr_offAtRise_val_no_value
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
*/
one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}
/*
one sig r3_trig1 extends r3_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}
*/


abstract sig r3_cond extends Condition {}
/*
one sig r3_cond0 extends r3_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime.time
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_setTime_attr_setTime
  value        = cap_setTime_attr_setTime_val_not_null
}
*/
abstract sig r3_comm extends Command {}
one sig r3_comm1 extends r3_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_LittleLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_LittleLight.now
  attribute    = cap_now_attr_now
  value        = cap_now_attr_now_val_lte_noValue
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_LittleLight.now
  attribute    = cap_now_attr_now
  value        = cap_now_attr_now_val_gte_noValue
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
*/

one sig r5 extends r {}{
  no triggers
  conditions = r5_cond
  commands   = r5_comm
}




abstract sig r5_cond extends Condition {}
/*
one sig r5_cond0 extends r5_cond {} {
  capabilities = app_LittleLight.user
  attribute    = cap_user_attr_onAtSet
  value        = cap_user_attr_onAtSet_val_no_value
}
*/
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_LittleLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_LittleLight.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val 
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val
}
one sig r6_comm1 extends r6_comm {} {
  capability   = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r7 extends r {}{
  no triggers
  conditions = r7_cond
  commands   = r7_comm
}




abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_LittleLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_LittleLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



