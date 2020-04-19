module app_KnockKnock

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_accelerationSensor
open cap_contactSensor


one sig app_KnockKnock extends IoTApp {
  
  accelSensor : one cap_accelerationSensor,
  
  contactSensor : one cap_contactSensor,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = accelSensor + contactSensor + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_shouldCheckForKnock extends cap_state_attr {} {
  values = cap_state_attr_shouldCheckForKnock_val
}

abstract sig cap_state_attr_shouldCheckForKnock_val extends AttrValue {}
one sig cap_state_attr_shouldCheckForKnock_val_false extends cap_state_attr_shouldCheckForKnock_val {}
one sig cap_state_attr_shouldCheckForKnock_val_true extends cap_state_attr_shouldCheckForKnock_val {}

one sig cap_state_attr_DoorWasOpened extends cap_state_attr {} {
  values = cap_state_attr_DoorWasOpened_val
}
abstract sig cap_state_attr_DoorWasOpened_val extends AttrValue {}
one sig cap_state_attr_DoorWasOpened_val_false extends cap_state_attr_DoorWasOpened_val {}
one sig cap_state_attr_DoorWasOpened_val_true extends cap_state_attr_DoorWasOpened_val {}
/*
abstract sig cap_state_attr_DoorWasOpened_val extends AttrValue {}
one sig cap_state_attr_DoorWasOpened_val_false extends cap_state_attr_DoorWasOpened_val {}
*/


abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_KnockKnock.accelSensor
  attribute    = cap_accelerationSensor_attr_acceleration
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_KnockKnock.accelSensor
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val - cap_accelerationSensor_attr_acceleration_val_active
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_KnockKnock.accelSensor
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val_inactive
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_KnockKnock.state
  attribute    = cap_state_attr_shouldCheckForKnock
  value        = cap_state_attr_shouldCheckForKnock_val_false
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_KnockKnock.accelSensor
  attribute    = cap_accelerationSensor_attr_acceleration
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_KnockKnock.accelSensor
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val_active
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_KnockKnock.state
  attribute    = cap_state_attr_DoorWasOpened
  value        = cap_state_attr_DoorWasOpened_val_false
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_KnockKnock.state
  attribute    = cap_state_attr_shouldCheckForKnock
  value        = cap_state_attr_shouldCheckForKnock_val_true
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_KnockKnock.contactSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_KnockKnock.state
  attribute    = cap_state_attr_shouldCheckForKnock
  value        = cap_state_attr_shouldCheckForKnock_val_true
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_KnockKnock.state
  attribute    = cap_state_attr_DoorWasOpened
  value        = cap_state_attr_DoorWasOpened_val_true
}



