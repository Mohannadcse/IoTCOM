module app_SmartNightlight

open IoTBottomUp as base

open cap_motionSensor
open cap_switch
open cap_illuminanceMeasurement


one sig app_SmartNightlight extends IoTApp {
  
  lightSensor : one cap_illuminanceMeasurement,
  
  state : one cap_state,
  
  motionSensor : one cap_motionSensor,
  
  lights : some cap_switch,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
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

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0//cap_illuminanceMeasurement_attr_illuminance_val_Range0
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartNightlight.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_motionStopTime
  value = cap_state_attr_motionStopTime_val_not_null
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r2_cond3 extends r2_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_2 //cap_illuminanceMeasurement_attr_illuminance_val_Range2
}
one sig r2_cond4 extends r2_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1 //cap_illuminanceMeasurement_attr_illuminance_val_Range1
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_SmartNightlight.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0//cap_illuminanceMeasurement_attr_illuminance_val_Range0
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_motionStopTime
  value = cap_state_attr_motionStopTime_val_null
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r4_cond1 extends r4_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}
one sig r4_cond2 extends r4_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val
}
one sig r4_cond3 extends r4_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r4_cond4 extends r4_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1//cap_illuminanceMeasurement_attr_illuminance_val_Range1
}
one sig r4_cond5 extends r4_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val_not_null
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_SmartNightlight.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r4_comm1 extends r4_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_SmartNightlight.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_SmartNightlight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_on
}
one sig r5_cond2 extends r5_cond {} {
  capabilities = app_SmartNightlight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0//cap_illuminanceMeasurement_attr_illuminance_val_Range0
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_SmartNightlight.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}
one sig r5_comm1 extends r5_comm {} {
  capability   = app_SmartNightlight.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_on
}



