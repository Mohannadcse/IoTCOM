module app_HallLightWelcomeHome

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_contactSensor
open cap_switch


one sig app_HallLightWelcomeHome extends IoTApp {
  
  people : some cap_presenceSensor,
  
  sensors : some cap_contactSensor,
  
  lights : one cap_switch,
} {
  rules = r
  //capabilities = people + sensors + lights
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_HallLightWelcomeHome.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HallLightWelcomeHome.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
/*
one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_HallLightWelcomeHome.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_HallLightWelcomeHome.state
  attribute    = cap_lastPresence_attr_lastPresence
  value        = cap_lastPresence_attr_lastPresence_val_not_null
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_HallLightWelcomeHome.sensors
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r2_cond extends Condition {}


abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_HallLightWelcomeHome.state
  attribute    = cap_lastContact_attr_lastContact
  value        = cap_lastContact_attr_lastContact_val_not_null
}
*/
one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_HallLightWelcomeHome.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}


abstract sig r3_cond extends Condition {}


abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_HallLightWelcomeHome.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



