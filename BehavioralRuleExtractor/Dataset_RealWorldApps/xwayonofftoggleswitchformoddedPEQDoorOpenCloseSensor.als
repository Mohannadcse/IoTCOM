module app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor extends IoTApp {
  
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
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_off
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_off
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.contact1
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_xwayonofftoggleswitchformoddedPEQDoorOpenCloseSensor.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



