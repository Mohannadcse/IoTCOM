module app_LeftItOpenStill

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor


one sig app_LeftItOpenStill extends IoTApp {
  
  contact : one cap_contactSensor,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LeftItOpenStill.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LeftItOpenStill.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



