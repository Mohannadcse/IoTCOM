module app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor extends IoTApp {
  
  contact1 : set cap_contactSensor,
  
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
  capabilities = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.switch1
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
  capabilities = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_MultiwayOnOffToggleSwitchUsingaModdedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



