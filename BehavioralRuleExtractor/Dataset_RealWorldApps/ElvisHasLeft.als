module app_ElvisHasLeft

open IoTBottomUp as base

open cap_userInput
open cap_motionSensor
open cap_contactSensor
open cap_thermostat


one sig app_ElvisHasLeft extends IoTApp {
  
  sendPushMessage : one cap_userInput,
  
  contactSensors : some cap_contactSensor,
  
  motionSensors : some cap_motionSensor,
  
  state : one cap_state,
  
  thermostats : some cap_thermostat,
} {
  rules = r
}


one sig cap_userInput_attr_sendPushMessage extends cap_userInput_attr {}
{
    values = cap_userInput_attr_sendPushMessage_val
} 
abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}

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



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ElvisHasLeft.contactSensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_closed
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ElvisHasLeft.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



