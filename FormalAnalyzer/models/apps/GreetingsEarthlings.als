module app_GreetingsEarthlings

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_location

one sig app_GreetingsEarthlings extends IoTApp {
  location : one cap_location,
  
  people : some cap_presenceSensor,
  
  state : one cap_state,

  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = people + state
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
  capabilities = app_GreetingsEarthlings.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_GreetingsEarthlings.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_GreetingsEarthlings.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_GreetingsEarthlings.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_GreetingsEarthlings.location
  attribute    = cap_location_attr_mode
  value        = app_GreetingsEarthlings.newMode
}



