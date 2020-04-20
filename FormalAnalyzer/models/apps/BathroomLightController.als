module app_BathroomLightController

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_contactSensor
open cap_switch


one sig app_BathroomLightController extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  contact2 : one cap_contactSensor,
  
  switch1 : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + contact2 + switch1 + state
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
  capabilities = app_BathroomLightController.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_BathroomLightController.switch1
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
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_BathroomLightController.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_BathroomLightController.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_BathroomLightController.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val - cap_contactSensor_attr_contact_val_open
}
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_BathroomLightController.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_BathroomLightController.contact2
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_BathroomLightController.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_BathroomLightController.switch1
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r5_cond extends Condition {}


abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_BathroomLightController.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



