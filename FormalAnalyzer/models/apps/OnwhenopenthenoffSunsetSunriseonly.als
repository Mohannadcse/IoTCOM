module app_OnwhenopenthenoffSunsetSunriseonly

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_location
open cap_userInput

one sig app_OnwhenopenthenoffSunsetSunriseonly extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switches : some cap_switch,
  
  time : one cap_userInput,
  now : one cap_now,
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + switches + time + state
}

abstract sig cap_userInput_attr_time_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_time_val_0 extends cap_userInput_attr_time_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



//one sig cap_now_attr_now_val_gte_noValue extends cap_now_attr_now_val {}
//one sig cap_now_attr_now_val_lte_noValue extends cap_now_attr_now_val {}

one sig range_ss_0, range_ss_1 extends cap_location_attr_sunsetTime_val {}
one sig range_sr_0, range_sr_1 extends cap_location_attr_sunriseTime_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_OnwhenopenthenoffSunsetSunriseonly.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.now
  attribute    = cap_now_attr_now
  value        = range_ss_0//cap_now_attr_now_val_lte_noValue
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.now
  attribute    = cap_now_attr_now
  value        = range_sr_1//cap_now_attr_now_val_gte_noValue
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_OnwhenopenthenoffSunsetSunriseonly.switches
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
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_OnwhenopenthenoffSunsetSunriseonly.time
  attribute    = cap_userInput_attr_time_val
  value        = cap_userInput_attr_time_val - cap_userInput_attr_time_val_0
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_OnwhenopenthenoffSunsetSunriseonly.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



