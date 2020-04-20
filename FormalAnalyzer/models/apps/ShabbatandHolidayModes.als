module app_ShabbatandHolidayModes

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_location
open cap_userInput

one sig app_ShabbatandHolidayModes extends IoTApp {
  location : one cap_location,
  
  sendPushMessage : one cap_userInput,
  
  state : one cap_state,

  startMode : one cap_location_attr_mode_val,
  endMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = sendPushMessage + state
}

abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_sendPushMessage_val_Yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_No extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ShabbatandHolidayModes.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ShabbatandHolidayModes.endMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ShabbatandHolidayModes.location
  attribute    = cap_location_attr_mode
  value        = app_ShabbatandHolidayModes.endMode
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ShabbatandHolidayModes.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ShabbatandHolidayModes.startMode
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ShabbatandHolidayModes.location
  attribute    = cap_location_attr_mode
  value        = app_ShabbatandHolidayModes.startMode
}



