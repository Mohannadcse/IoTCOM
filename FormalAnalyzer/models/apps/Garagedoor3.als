module app_Garagedoor3

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_presenceSensor


one sig app_Garagedoor3 extends IoTApp {
  
  doorSensor : one cap_contactSensor,
  
  doorSwitch : one cap_switch,
  
  cars : some cap_presenceSensor,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = doorSensor + doorSwitch + cars + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_openDoorNotificationSent extends cap_state_attr {} {
  values = cap_state_attr_openDoorNotificationSent_val
}

abstract sig cap_state_attr_openDoorNotificationSent_val extends AttrValue {}
one sig cap_state_attr_openDoorNotificationSent_val_false extends cap_state_attr_openDoorNotificationSent_val {}
one sig cap_state_attr_openDoorNotificationSent_val_true extends cap_state_attr_openDoorNotificationSent_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_Garagedoor3.doorSensor
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_Garagedoor3.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_Garagedoor3.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_appOpenedDoor_attr_appOpenedDoor
  value        = cap_appOpenedDoor_attr_appOpenedDoor_val_not_null
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_Garagedoor3.user
  attribute    = cap_user_attr_openThreshold
  value        = cap_user_attr_openThreshold_val_no_value
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_openDoorNotificationSent_attr_openDoorNotificationSent
  value        = cap_openDoorNotificationSent_attr_openDoorNotificationSent_val_true
}

one sig r3 extends r {}{
  no triggers
  conditions = r3_cond
  commands   = r3_comm
}




abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_Garagedoor3.user
  attribute    = cap_user_attr_openThreshold
  value        = cap_user_attr_openThreshold_val_no_value
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_Garagedoor3.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_openDoorNotificationSent_attr_openDoorNotificationSent
  value        = cap_openDoorNotificationSent_attr_openDoorNotificationSent_val_true
}
*/
one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_Garagedoor3.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_Garagedoor3.doorSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r4_comm1 extends r4_comm {} {
  capability   = app_Garagedoor3.doorSwitch
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
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_Garagedoor3.cars
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_Garagedoor3.doorSensor
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_Garagedoor3.doorSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r5_comm1 extends r5_comm {} {
  capability   = app_Garagedoor3.doorSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
/*
one sig r6 extends r {}{
  no triggers
  conditions = r6_cond
  commands   = r6_comm
}




abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_Garagedoor3.user
  attribute    = cap_user_attr_openThreshold
  value        = cap_user_attr_openThreshold_val_no_value
}
one sig r6_cond1 extends r6_cond {} {
  capabilities = app_Garagedoor3.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_openDoorNotificationSent_attr_openDoorNotificationSent
  value        = cap_openDoorNotificationSent_attr_openDoorNotificationSent_val_false
}

one sig r7 extends r {}{
  no triggers
  conditions = r7_cond
  commands   = r7_comm
}




abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_Garagedoor3.user
  attribute    = cap_user_attr_openThreshold
  value        = cap_user_attr_openThreshold_val_no_value
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_Garagedoor3.state
  attribute    = cap_openDoorNotificationSent_attr_openDoorNotificationSent
  value        = cap_openDoorNotificationSent_attr_openDoorNotificationSent_val_false
}
*/


