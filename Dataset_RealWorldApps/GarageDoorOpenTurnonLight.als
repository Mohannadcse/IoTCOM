module app_GarageDoorOpenTurnonLight

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_switch

open cap_location

one sig app_GarageDoorOpenTurnonLight extends IoTApp {
  location : one cap_location,
  
  garageContact : one cap_contactSensor,
  
  switches : some cap_switch,
  
  switchesOff : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = garageContact + switches + switchesOff + state
}


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
  capabilities = app_GarageDoorOpenTurnonLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_GarageDoorOpenTurnonLight.switchesOff
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
  capabilities = app_GarageDoorOpenTurnonLight.garageContact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_GarageDoorOpenTurnonLight.location
  attribute    = cap_location_attr_sunSet
  value        = cap_location_attr_sunSet_val_ON
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_GarageDoorOpenTurnonLight.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_GarageDoorOpenTurnonLight.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



