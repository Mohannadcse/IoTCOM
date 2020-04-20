module app_ID17SleepingModeTurnOffDevices

open IoTBottomUp as base

open cap_location
open cap_switch
open cap_runIn


one sig app_ID17SleepingModeTurnOffDevices extends IoTApp {
  
  theSwitches : set cap_switch,
  
  runIn : one cap_state,
  
  state : one cap_state,
  
  location : one cap_location,
} {
  rules = r
}



one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_switchesTurnedOff extends cap_state_attr {} {
  values = cap_state_attr_switchesTurnedOff_val
}

abstract sig cap_state_attr_switchesTurnedOff_val extends AttrValue {}
one sig cap_state_attr_switchesTurnedOff_val_true extends cap_state_attr_switchesTurnedOff_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  no conditions
  commands   = r0_comm
}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID17SleepingModeTurnOffDevices.state
  attribute = cap_state_attr_switchesTurnedOff
  value = cap_state_attr_switchesTurnedOff_val_true
}

one sig r1 extends r {}{
  no triggers
  no conditions
  commands   = r1_comm
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID17SleepingModeTurnOffDevices.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}



