module app_NotifyDoorbellandTurnonLights

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_location


lone sig app_NotifyDoorbellandTurnonLights extends IoTApp {
  
  contact : some cap_contactSensor,
  location : one cap_location,
  switches : some cap_switch,
} {
  rules = r
  //capabilities = contact + switches
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_NotifyDoorbellandTurnonLights.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_NotifyDoorbellandTurnonLights.location
  attribute    = cap_location_attr_sunSet
  value        = cap_location_attr_sunSet_val_ON
}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_NotifyDoorbellandTurnonLights.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_NotifyDoorbellandTurnonLights.switches
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
  capabilities = app_NotifyDoorbellandTurnonLights.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_NotifyDoorbellandTurnonLights.location
  attribute    = cap_location_attr_sunRise
  value        = cap_location_attr_sunRise_val_ON
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_NotifyDoorbellandTurnonLights.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_NotifyDoorbellandTurnonLights.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
