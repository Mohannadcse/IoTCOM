module app_LightTurnonClosed

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_LightTurnonClosed extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switch1 : one cap_switch,
} {
  rules = r
  //capabilities = contact1 + switch1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LightTurnonClosed.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LightTurnonClosed.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



