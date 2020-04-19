module app_ModifiedRidGarageOpener

open IoTBottomUp as base

open cap_contactSensor
open cap_lock//cap_momentary
open cap_presenceSensor
open cap_userInput

one sig app_ModifiedRidGarageOpener extends IoTApp {
  
  doorSensor : one cap_contactSensor,
  
  cars : some cap_presenceSensor,
  
  state : one cap_state,
  user : one cap_userInput,
  doorSwitch : one cap_lock,//cap_momentary,
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

one sig cap_state_attr_openDoorNotificationSent extends cap_state_attr {} {
  values = cap_state_attr_openDoorNotificationSent_val
}

abstract sig cap_state_attr_openDoorNotificationSent_val extends AttrValue {}
one sig cap_state_attr_openDoorNotificationSent_val_false extends cap_state_attr_openDoorNotificationSent_val {}
one sig cap_state_attr_openDoorNotificationSent_val_true extends cap_state_attr_openDoorNotificationSent_val {}

one sig cap_state_attr_appOpenedDoor extends cap_state_attr {} {
  values = cap_state_attr_appOpenedDoor_val
}

one sig cap_state_attr_appOpenedDoor_val extends AttrValue {}

one sig cap_userInput_attr_openThreshold extends cap_userInput_attr {} {
  values = cap_userInput_attr_openThreshold_val
}

one sig cap_userInput_attr_openThreshold_val extends AttrValue {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ModifiedRidGarageOpener.doorSensor
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ModifiedRidGarageOpener.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_ModifiedRidGarageOpener.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ModifiedRidGarageOpener.doorSwitch
  attribute = cap_lock_attr_lock //cap_momentary_attr_momentary
  value = cap_lock_attr_lock_val_locked //cap_momentary_attr_momentary_val_push
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_ModifiedRidGarageOpener.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_appOpenedDoor
  value = cap_state_attr_appOpenedDoor_val
}

one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}




abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ModifiedRidGarageOpener.user
  attribute    = cap_userInput_attr_openThreshold
  value        = cap_userInput_attr_openThreshold_val
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_openDoorNotificationSent
  value = cap_state_attr_openDoorNotificationSent_val_true
}

one sig r4 extends r {}{
  no triggers
  conditions = r4_cond
  commands   = r4_comm
}




abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_ModifiedRidGarageOpener.user
  attribute    = cap_userInput_attr_openThreshold
  value        = cap_userInput_attr_openThreshold_val
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_ModifiedRidGarageOpener.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_openDoorNotificationSent
  value = cap_state_attr_openDoorNotificationSent_val_true
}

one sig r5 extends r {}{
  no triggers
  conditions = r5_cond
  commands   = r5_comm
}




abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_ModifiedRidGarageOpener.user
  attribute    = cap_userInput_attr_openThreshold
  value        = cap_userInput_attr_openThreshold_val
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_ModifiedRidGarageOpener.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_openDoorNotificationSent
  value = cap_state_attr_openDoorNotificationSent_val_false
}

one sig r6 extends r {}{
  no triggers
  conditions = r6_cond
  commands   = r6_comm
}




abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_ModifiedRidGarageOpener.user
  attribute    = cap_userInput_attr_openThreshold
  value        = cap_userInput_attr_openThreshold_val
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_ModifiedRidGarageOpener.state
  attribute = cap_state_attr_openDoorNotificationSent
  value = cap_state_attr_openDoorNotificationSent_val_false
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_ModifiedRidGarageOpener.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_ModifiedRidGarageOpener.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_ModifiedRidGarageOpener.doorSwitch
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_unlocked //cap_momentary_attr_momentary_val_push
}



