module app_DrytheWetspot

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_waterSensor
open cap_switch
open cap_userInput

one sig app_DrytheWetspot extends IoTApp {
  
  sensor : one cap_waterSensor,
  
  pump : one cap_switch,
  //delay : one cap_userInput,
  state : one cap_state,
} {
  rules = r
  //capabilities = sensor + pump + state 
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

//abstract sig cap_userInput_attr_delay_val extends cap_userInput_attr_value_val {}

one sig cap_state_attr_delay extends cap_state_attr {} {
  values = cap_state_attr_delay_val
}

abstract sig cap_state_attr_delay_val extends AttrValue {}
one sig cap_state_attr_delay_val_false extends cap_state_attr_delay_val {}
one sig cap_state_attr_delay_val_true extends cap_state_attr_delay_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_DrytheWetspot.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DrytheWetspot.pump
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}
/*
one sig r1_trig0 extends r1_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_dry
}
*/
one sig r1_trig1 extends r1_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}



abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_DrytheWetspot.state
  attribute    = cap_state_attr_delay
  value        = cap_state_attr_delay_val - cap_state_attr_delay_val_true
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DrytheWetspot.pump
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_dry
}
/*
one sig r2_trig1 extends r2_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}
*/


abstract sig r2_cond extends Condition {}
/*
one sig r2_cond0 extends r2_cond {} {
  capabilities = app_DrytheWetspot.user
  attribute    = cap_user_attr_timeout
  value        = cap_user_attr_timeout_val_no_value
}
*/
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val - cap_waterSensor_attr_water_val_wet
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_dry
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_DrytheWetspot.state
  attribute    = cap_state_attr_delay
  value        = cap_state_attr_delay_val_true
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_DrytheWetspot.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}




abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_DrytheWetspot.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_DrytheWetspot.state
  attribute    = cap_state_attr_delay
  value        = cap_state_attr_delay_val_false
}
/*
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_dry
}
one sig r4_trig1 extends r4_trig {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water.dry
  value        = cap_waterSensor_attr_water.dry_val - cap_waterSensor_attr_water.dry_val_wet
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_DrytheWetspot.sensor
  attribute    = cap_waterSensor_attr_water.dry
  value        = cap_waterSensor_attr_water.dry_val_dry
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_DrytheWetspot.pump
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
*/


