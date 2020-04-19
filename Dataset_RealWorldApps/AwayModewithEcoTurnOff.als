module app_AwayModewithEcoTurnOff

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_switch
open cap_contactSensor
open cap_location
open cap_userInput

one sig app_AwayModewithEcoTurnOff extends IoTApp {
  location : one cap_location,
  
  people : some cap_presenceSensor,
  
  switches : some cap_switch,
  
  contacts : some cap_contactSensor,
  
  sendPushMessage : one cap_userInput,

  newMode: one cap_location_attr_mode_val,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = people + switches + contacts + sendPushMessage + state
  //sendPushMessage.state[System][cap_userInput_attr_value] in cap_userInput_attr_value_boolval
}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}




abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_AwayModewithEcoTurnOff.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_AwayModewithEcoTurnOff.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_AwayModewithEcoTurnOff.newMode
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_AwayModewithEcoTurnOff.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_AwayModewithEcoTurnOff.state
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
  capabilities = app_AwayModewithEcoTurnOff.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_AwayModewithEcoTurnOff.location
  attribute    = cap_location_attr_mode
  value        = app_AwayModewithEcoTurnOff.newMode
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_AwayModewithEcoTurnOff.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



