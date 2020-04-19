module app_MaliciousApp

open IoTBottomUp as base

open cap_presenceSensor
open cap_location

lone sig app_MaliciousApp extends IoTApp {
  
  presence : one cap_presenceSensor,
  location : one cap_location,
  state : one cap_state,
} {
  rules = r
  //capabilities = presence + state
}


one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_HomeMode extends cap_state_attr_mode_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_MaliciousApp.presence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_MaliciousApp.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - cap_location_attr_mode_val_Home
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_MaliciousApp.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MaliciousApp.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val_Home
}



