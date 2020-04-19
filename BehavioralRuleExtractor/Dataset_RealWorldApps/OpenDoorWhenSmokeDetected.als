module app_OpenDoorWhenSmokeDetected

open IoTBottomUp as base

open cap_contactSensor
open cap_momentary
open cap_smokeDetector
open cap_location


one sig app_OpenDoorWhenSmokeDetected extends IoTApp {
  
  doorSensor : one cap_contactSensor,
  
  state : one cap_state,
  
  doorSwitch : one cap_momentary,
  
  contact : some cap_contactSensor,
  
  smoke : some cap_smokeDetector,
  
  detected : one cap_location_attr_mode_val,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}

one sig cap_momentary_attr_momentary extends cap_momentary_attr {} {
  values = cap_momentary_attr_momentary_val
}

abstract sig cap_momentary_attr_momentary_val extends AttrValue {}
one sig cap_momentary_attr_momentary_val_push extends cap_momentary_attr_momentary_val {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_OpenDoorWhenSmokeDetected.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_OpenDoorWhenSmokeDetected.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_OpenDoorWhenSmokeDetected.doorSwitch
  attribute = cap_momentary_attr_momentary
  value = cap_momentary_attr_momentary_val_push
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_OpenDoorWhenSmokeDetected.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = app_OpenDoorWhenSmokeDetected.detected 
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_OpenDoorWhenSmokeDetected.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_OpenDoorWhenSmokeDetected.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



