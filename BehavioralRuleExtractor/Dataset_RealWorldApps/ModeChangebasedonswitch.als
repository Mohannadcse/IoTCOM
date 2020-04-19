module app_ModeChangebasedonswitch

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_location

one sig app_ModeChangebasedonswitch extends IoTApp {
  location : one cap_location,
  
  theSwitch : one cap_switch,
  
  state : one cap_state,
  /*
  mode1 : one cap_location_attr_mode_val,
  mode2 : one cap_location_attr_mode_val,
  mode3 : one cap_location_attr_mode_val,
  mode4 : one cap_location_attr_mode_val,
  */
} {
  rules = r
  //capabilities = theSwitch + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_location_attr_mode_val_mode1 extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_mode2 extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_mode3 extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_mode4 extends cap_location_attr_mode_val {}{}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r0_cond extends Condition {}
/*
one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = app_ModeChangebasedonswitch.mode1
}
*/
one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode1
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode2 //app_ModeChangebasedonswitch.mode2
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_cond extends Condition {}
/*
one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}
*/
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode1 //app_ModeChangebasedonswitch.mode1
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode2 //app_ModeChangebasedonswitch.mode2
}
/*
one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = app_ModeChangebasedonswitch.mode2
}


one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_On
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = app_ModeChangebasedonswitch.mode2
}
*/
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r4_cond extends Condition {}
/*
one sig r4_cond0 extends r4_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}
*/

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode4 //app_ModeChangebasedonswitch.mode4
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r5_cond extends Condition {}
/*
one sig r5_cond0 extends r5_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_null
}
*/
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode3 //app_ModeChangebasedonswitch.mode3
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_ModeChangebasedonswitch.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_mode4 //app_ModeChangebasedonswitch.mode4
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r6_cond extends Condition {}


abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r7_cond extends Condition {}


abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_ModeChangebasedonswitch.theSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



