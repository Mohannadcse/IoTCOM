module app_PowerOnWhenMotion

open IoTBottomUp as base
open cap_runIn
open cap_now
open cap_userInput
open cap_motionSensor
open cap_switch


one sig app_PowerOnWhenMotion extends IoTApp {
  
  motion : one cap_motionSensor,
  
  mySwitch : set cap_switch,
  frequency : one cap_userInput,
  state : one cap_state,
} {
  rules = r
  //capabilities = motion + mySwitch + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_InActiveTurnOff extends cap_state_attr {} {
  values = cap_state_attr_InActiveTurnOff_val
}

abstract sig cap_state_attr_InActiveTurnOff_val extends AttrValue {}
one sig cap_state_attr_InActiveTurnOff_val_false extends cap_state_attr_InActiveTurnOff_val {}
one sig cap_state_attr_InActiveTurnOff_val_true extends cap_state_attr_InActiveTurnOff_val {}

one sig cap_userInput_attr_frequency extends cap_userInput_attr {}
{
    values = cap_userInput_attr_frequency_val
} 
abstract sig cap_userInput_attr_frequency_val extends cap_userInput_attr_value_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_PowerOnWhenMotion.state
  attribute    = cap_state_attr_InActiveTurnOff
  value        = cap_state_attr_InActiveTurnOff_val_true
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_PowerOnWhenMotion.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_PowerOnWhenMotion.mySwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_PowerOnWhenMotion.state
  attribute    = cap_state_attr_InActiveTurnOff
  value        = cap_state_attr_InActiveTurnOff_val_false
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_PowerOnWhenMotion.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_PowerOnWhenMotion.mySwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_PowerOnWhenMotion.state
  attribute    = cap_state_attr_InActiveTurnOff
  value        = cap_state_attr_InActiveTurnOff_val_false
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_PowerOnWhenMotion.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_PowerOnWhenMotion.frequency
  attribute    = cap_userInput_attr_frequency
  value        = cap_userInput_attr_frequency_val
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_PowerOnWhenMotion.state
  attribute    = cap_state_attr_InActiveTurnOff
  value        = cap_state_attr_InActiveTurnOff_val_true
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_PowerOnWhenMotion.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



