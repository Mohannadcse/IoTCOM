module app_LightsonwhenIarriveinthedark

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_contactSensor
open cap_motionSensor
open cap_illuminanceMeasurement


one sig app_LightsonwhenIarriveinthedark extends IoTApp {
  
  lights : some cap_switch,
  
  contact1 : one cap_contactSensor,
  
  motionSensor : one cap_motionSensor,
  
  lightSensor : one cap_illuminanceMeasurement,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = lights + contact1 + motionSensor + lightSensor + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_lastStatus extends cap_state_attr {} {
  values = cap_state_attr_lastStatus_val
}

abstract sig cap_state_attr_lastStatus_val extends AttrValue {}
one sig cap_state_attr_lastStatus_val_on extends cap_state_attr_lastStatus_val {}
one sig cap_state_attr_lastStatus_val_off extends cap_state_attr_lastStatus_val {}

one sig cap_state_attr_motionStopTime extends cap_state_attr {} {
  values = cap_state_attr_motionStopTime_val
}

abstract sig cap_state_attr_motionStopTime_val extends AttrValue {}
one sig cap_state_attr_motionStopTime_val_not_null extends cap_state_attr_motionStopTime_val {}
one sig cap_state_attr_motionStopTime_val_null extends cap_state_attr_motionStopTime_val {}


one sig range_0,range_1,range_2 extends cap_illuminanceMeasurement_attr_illuminance_val {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val_null
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val_not_null
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_2
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1
}
one sig r3_cond3 extends r3_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_on
}
one sig r3_cond4 extends r3_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  //value        = cap_illuminanceMeasurement_attr_illuminance_val_Range0
  value        = range_0
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r3_comm1 extends r3_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r4_comm1 extends r4_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}
/*
one sig r5 extends r {}{
  no triggers
  conditions = r5_cond
  commands   = r5_comm
}




abstract sig r5_cond extends Condition {}


abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_riseTime_attr_riseTime
  value        = cap_riseTime_attr_riseTime_val_not_null
}
one sig r5_comm1 extends r5_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_setTime_attr_setTime
  value        = cap_setTime_attr_setTime_val_not_null
}
*/

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r6_cond1 extends r6_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r6_cond2 extends r6_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r6_cond3 extends r6_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1
}
one sig r6_cond4 extends r6_cond {} {
  capabilities = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r6_comm1 extends r6_comm {} {
  capability   = app_LightsonwhenIarriveinthedark.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}



