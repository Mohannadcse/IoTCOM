module app_OpeningDoorTogglesSwitch

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_OpeningDoorTogglesSwitch extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switch1 : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + switch1 + state
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
  capabilities = app_OpeningDoorTogglesSwitch.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_OpeningDoorTogglesSwitch.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_OpeningDoorTogglesSwitch.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_OpeningDoorTogglesSwitch.switch1
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
  capabilities = app_OpeningDoorTogglesSwitch.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r2_cond extends Condition {}


abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_OpeningDoorTogglesSwitch.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



