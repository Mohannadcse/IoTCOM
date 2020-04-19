module app_OpenGarage

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_contactSensor
open cap_switch


one sig app_OpenGarage extends IoTApp {
  
  presence1 : some cap_presenceSensor,
  
  GarageDoorContact : one cap_contactSensor,
  
  GarageDoorOpener : one cap_switch,
} {
  rules = r
  //capabilities = presence1 + GarageDoorContact + GarageDoorOpener
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_OpenGarage.presence1
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_OpenGarage.presence1
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_OpenGarage.GarageDoorOpener
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_OpenGarage.GarageDoorOpener
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



