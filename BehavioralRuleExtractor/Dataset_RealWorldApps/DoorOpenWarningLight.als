module app_DoorOpenWarningLight

open IoTBottomUp as base

open cap_motionSensor
open cap_switch
open cap_contactSensor


one sig app_DoorOpenWarningLight extends IoTApp {
  
  sensors : some cap_motionSensor,
  
  switch1 : one cap_switch,
  
  state : one cap_state,
  
  contacts : some cap_contactSensor,
} {
  rules = r
}



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

one sig cap_state_attr_scheduledLightOn extends cap_state_attr {} {
  values = cap_state_attr_scheduledLightOn_val
}

abstract sig cap_state_attr_scheduledLightOn_val extends AttrValue {}
one sig cap_state_attr_scheduledLightOn_val_true extends cap_state_attr_scheduledLightOn_val {}
one sig cap_state_attr_scheduledLightOn_val_false extends cap_state_attr_scheduledLightOn_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_DoorOpenWarningLight.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_scheduledLightOn
  value = cap_state_attr_scheduledLightOn_val_false
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_DoorOpenWarningLight.sensors
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val //- cap_switch_attr__val_no_value
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DoorOpenWarningLight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_DoorOpenWarningLight.contacts
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val //- cap_switch_attr__val_no_value
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_DoorOpenWarningLight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_DoorOpenWarningLight.contacts
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_DoorOpenWarningLight.state
  attribute    = cap_state_attr_scheduledLightOn
  value        = cap_state_attr_scheduledLightOn_val
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_scheduledLightOn
  value = cap_state_attr_scheduledLightOn_val_false
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_DoorOpenWarningLight.contacts
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_DoorOpenWarningLight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_DoorOpenWarningLight.sensors
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_DoorOpenWarningLight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_DoorOpenWarningLight.sensors
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val //- cap_switch_attr__val_no_value
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}
one sig r6_comm1 extends r6_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_scheduledLightOn
  value = cap_state_attr_scheduledLightOn_val_true
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_DoorOpenWarningLight.sensors
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_DoorOpenWarningLight.state
  attribute    = cap_state_attr_scheduledLightOn
  value        = cap_state_attr_scheduledLightOn_val
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_scheduledLightOn
  value = cap_state_attr_scheduledLightOn_val_false
}

one sig r8 extends r {}{
  no triggers
  conditions = r8_cond
  commands   = r8_comm
}




abstract sig r8_cond extends Condition {}

one sig r8_cond0 extends r8_cond {} {
  capabilities = app_DoorOpenWarningLight.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r8_comm extends Command {}

one sig r8_comm0 extends r8_comm {} {
  capability   = app_DoorOpenWarningLight.switch1
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r9 extends r {}{
  triggers   = r9_trig
  conditions = r9_cond
  commands   = r9_comm
}

abstract sig r9_trig extends Trigger {}

one sig r9_trig0 extends r9_trig {} {
  capabilities = app_DoorOpenWarningLight.contacts
  attribute    = cap_contactSensor_attr_contact
  no value
}


abstract sig r9_cond extends Condition {}

one sig r9_cond0 extends r9_cond {} {
  capabilities = app_DoorOpenWarningLight.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val //- cap_switch_attr__val_no_value
}

abstract sig r9_comm extends Command {}

one sig r9_comm0 extends r9_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}
one sig r9_comm1 extends r9_comm {} {
  capability   = app_DoorOpenWarningLight.state
  attribute = cap_state_attr_scheduledLightOn
  value = cap_state_attr_scheduledLightOn_val_true
}



