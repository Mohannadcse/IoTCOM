module app_turnGBallroomon

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_contactSensor


one sig app_turnGBallroomon extends IoTApp {
  
  switch1 : one cap_switch,
  
  ct1 : one cap_contactSensor,
} {
  rules = r
  //capabilities = switch1 + ct1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_turnGBallroomon.ct1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_turnGBallroomon.switch1
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
  capabilities = app_turnGBallroomon.ct1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turnGBallroomon.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



