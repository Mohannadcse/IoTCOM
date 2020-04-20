module app_ID9DisableVacationMode

open IoTBottomUp as base

open cap_userInput
open cap_location
open cap_switch
open cap_presenceSensor


one sig app_ID9DisableVacationMode extends IoTApp {
  
  people : some cap_presenceSensor,
  
  light : one cap_switch,
  
  no_value : one cap_location_attr_mode_val,
  
  phone : one cap_userInput,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
  
  myswitch : one cap_switch,
} {
  rules = r
}


one sig cap_userInput_attr_phone extends cap_userInput_attr {}
{
    values = cap_userInput_attr_phone_val
} 
abstract sig cap_userInput_attr_phone_val extends cap_userInput_attr_value_val {}

one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newMode extends cap_state_attr_mode_val {}

one sig cap_state_attr_vacation extends cap_state_attr {} {
  values = cap_state_attr_vacation_val
}

abstract sig cap_state_attr_vacation_val extends AttrValue {}
one sig cap_state_attr_vacation_val_false extends cap_state_attr_vacation_val {}
one sig cap_state_attr_vacation_val_true extends cap_state_attr_vacation_val {}

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
  capabilities = app_ID9DisableVacationMode.myswitch
  attribute    = cap_switch_attr_switch
  no value
  //value        = cap_switch_attr_switch_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID9DisableVacationMode.myswitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID9DisableVacationMode.state
  attribute = cap_state_attr_vacation
  value = cap_state_attr_vacation_val_false
}

one sig r1 extends r {}{
  no triggers
  no conditions
  commands   = r1_comm
}



abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID9DisableVacationMode.state
  attribute = cap_state_attr_home
  value = cap_state_attr_home_val_true
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ID9DisableVacationMode.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID9DisableVacationMode.phone
  attribute    = cap_userInput_attr_phone
  value        = cap_userInput_attr_phone_val
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_ID9DisableVacationMode.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID9DisableVacationMode.newMode
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_ID9DisableVacationMode.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID9DisableVacationMode.location
  attribute = cap_location_attr_mode
  value        = app_ID9DisableVacationMode.newMode
}

one sig r2_comm1 extends r2_comm {} {
  capability   = app_ID9DisableVacationMode.location
  attribute = cap_location_attr_mode
  value = cap_location_attr_mode_val_Home
}

one sig r3 extends r {}{
  no triggers
  no conditions
  commands   = r3_comm
}


abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ID9DisableVacationMode.light
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_ID9DisableVacationMode.myswitch
  attribute    = cap_switch_attr_switch
  no value
  //value        = cap_switch_attr_switch_val
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_ID9DisableVacationMode.myswitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_ID9DisableVacationMode.state
  attribute = cap_state_attr_vacation
  value = cap_state_attr_vacation_val_true
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_ID9DisableVacationMode.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_ID9DisableVacationMode.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_ID9DisableVacationMode.location
  attribute = cap_location_attr_mode
  value = cap_location_attr_mode_val_Home
}

one sig r6 extends r {}{
  no triggers
  no conditions
  commands   = r6_comm
}


abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_ID9DisableVacationMode.light
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r7 extends r {}{
  no triggers
  conditions = r7_cond
  commands   = r7_comm
}




abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_ID9DisableVacationMode.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ID9DisableVacationMode.no_value
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_ID9DisableVacationMode.state
  attribute = cap_state_attr_home
  value = cap_state_attr_home_val_false
}



