module app_GarageAfterDark

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_GarageAfterDark extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  theDoor : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + theDoor + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_hasRandomSchedule extends cap_state_attr {} {
  values = cap_state_attr_hasRandomSchedule_val
}
abstract sig cap_state_attr_hasRandomSchedule_val extends AttrValue {}
one sig cap_state_attr_hasRandomSchedule_val_true extends cap_state_attr_hasRandomSchedule_val {}

one sig cap_state_attr_setTime extends cap_state_attr {} {
  values = cap_state_attr_setTime_val
}
abstract sig cap_state_attr_setTime_val extends AttrValue {}
one sig cap_state_attr_setTime_val_null extends cap_state_attr_setTime_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_GarageAfterDark.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_GarageAfterDark.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime
}
*/

one sig r0_cond1 extends r0_cond {} {
  capabilities   = app_GarageAfterDark.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}
/*
one sig r0_comm0 extends r0_comm {} {
  capability   = app_GarageAfterDark.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val
}
*/
one sig r0_comm0 extends r0_comm {} {
  capability   = app_GarageAfterDark.theDoor
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}
/*
one sig r1_cond0 extends r1_cond {} {
  capabilities = app_GarageAfterDark.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val - cap_state_attr_setTime_val_setTime
}
*/

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_GarageAfterDark.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val
}


one sig r1_comm1 extends r1_comm {} {
  capability = app_GarageAfterDark.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}




