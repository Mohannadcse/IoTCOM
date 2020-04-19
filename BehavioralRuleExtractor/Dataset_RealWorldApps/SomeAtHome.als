module app_SomeAtHome

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_presenceSensor
open cap_location

one sig app_SomeAtHome extends IoTApp {
  location : one cap_location,
  
  peopleHome : some cap_presenceSensor,
  
  peopleAway : some cap_presenceSensor,
  
  state : one cap_state,

  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = peopleHome + peopleAway + state
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
  capabilities = app_SomeAtHome.peopleAway
  attribute    = cap_presenceSensor_attr_presence
  no value
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_SomeAtHome.peopleHome
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SomeAtHome.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_SomeAtHome.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SomeAtHome.state
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
  capabilities = app_SomeAtHome.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SomeAtHome.location
  attribute    = cap_location_attr_mode
  value        = app_SomeAtHome.newMode
}



