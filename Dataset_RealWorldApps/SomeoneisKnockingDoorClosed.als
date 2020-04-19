module app_SomeoneisKnockingDoorClosed

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_accelerationSensor
open cap_contactSensor
open cap_switch


one sig app_SomeoneisKnockingDoorClosed extends IoTApp {
  
  acceleration : one cap_accelerationSensor,
  
  contact : one cap_contactSensor,
  
  switches : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = acceleration + contact + switches + state
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
  capabilities = app_SomeoneisKnockingDoorClosed.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.switches
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
  capabilities = app_SomeoneisKnockingDoorClosed.acceleration
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val_active
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
/*
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.switches
  attribute    = cap_switch_attr_any
  value        = cap_switch_attr_any_val_no_value
}

one sig r1_cond2 extends r1_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.user
  attribute    = cap_user_attr_frequency
  value        = cap_user_attr_frequency_val_no_value
}
*/
abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_SomeoneisKnockingDoorClosed.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r2_cond extends Condition {}


abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.state
  attribute    = cap_lastClosed_attr_lastClosed
  value        = cap_lastClosed_attr_lastClosed_val_not_null
}
*/
one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_SomeoneisKnockingDoorClosed.acceleration
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val_active
}


abstract sig r3_cond extends Condition {}
/*
one sig r3_cond0 extends r3_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.user
  attribute    = cap_user_attr_frequency
  value        = cap_user_attr_frequency_val - cap_user_attr_frequency_val_no_value
}
*/
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}
/*
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_SomeoneisKnockingDoorClosed.switches
  attribute    = cap_switch_attr_any
  value        = cap_switch_attr_any_val_no_value
}
*/
abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r3_comm1 extends r3_comm {} {
  capability   = app_SomeoneisKnockingDoorClosed.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



