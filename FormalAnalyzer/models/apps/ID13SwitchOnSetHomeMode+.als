module app_ID13SwitchOnSetHomeMode

open IoTBottomUp as base

open cap_userInput
open cap_location
open cap_switch


one sig app_ID13SwitchOnSetHomeMode extends IoTApp {
  
  mySwitch : set cap_switch,
  
  phone : one cap_userInput,
  
  location : one cap_location,
} {
  rules = r
}


one sig cap_userInput_attr_phone extends cap_userInput_attr {}
{
    values = cap_userInput_attr_phone_val
} 
abstract sig cap_userInput_attr_phone_val extends cap_userInput_attr_value_val {}





// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID13SwitchOnSetHomeMode.mySwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID13SwitchOnSetHomeMode.phone
  attribute    = cap_userInput_attr_phone
  value        = cap_userInput_attr_phone_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID13SwitchOnSetHomeMode.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_Home
}



