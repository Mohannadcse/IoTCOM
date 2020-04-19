module app_SmartNightlightPlus

open IoTBottomUp as base

open cap_motionSensor
open cap_switch
open cap_illuminanceMeasurement


one sig app_SmartNightlightPlus extends IoTApp {
  
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


one sig cap_state_attr_pushed extends cap_state_attr {} {
  values = cap_state_attr_pushed_val
}

abstract sig cap_state_attr_pushed_val extends AttrValue {}
one sig cap_state_attr_pushed_val_ extends cap_state_attr_pushed_val {}
one sig cap_state_attr_pushed_val_pushed extends cap_state_attr_pushed_val {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}

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


one sig cap_state_attr_riseTime extends cap_state_attr {} {
  values = cap_state_attr_riseTime_val
}

abstract sig cap_state_attr_riseTime_val extends AttrValue {}


one sig cap_state_attr_setTime extends cap_state_attr {} {
  values = cap_state_attr_setTime_val
}

abstract sig cap_state_attr_setTime_val extends AttrValue {}


// application rules base class

abstract sig r extends Rule {}

one sig r11 extends r {}{
  no triggers
  conditions = r11_cond
  commands   = r11_comm
}




abstract sig r11_cond extends Condition {}


abstract sig r11_comm extends Command {}

one sig r11_comm0 extends r11_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_riseTime
  value = cap_state_attr_riseTime_val
}
one sig r11_comm1 extends r11_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_setTime
  value = cap_state_attr_setTime_val
}

one sig r12 extends r {}{
  triggers   = r12_trig
  conditions = r12_cond
  commands   = r12_comm
}

abstract sig r12_trig extends Trigger {}

one sig r12_trig0 extends r12_trig {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r12_cond extends Condition {}

one sig r12_cond0 extends r12_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r12_cond1 extends r12_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r12_cond2 extends r12_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r12_cond3 extends r12_cond {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1//cap_illuminanceMeasurement_attr_illuminance_val_Range1
}
one sig r12_cond4 extends r12_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r12_comm extends Command {}

one sig r12_comm0 extends r12_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r12_comm1 extends r12_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_2//cap_illuminanceMeasurement_attr_illuminance_val_Range2
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_pushed
  value        = cap_state_attr_pushed_val - cap_state_attr_pushed_val_pushed
}
/*
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SmartNightlightPlus.user
  attribute    = cap_user_attr_delayMinutes
  value        = cap_user_attr_delayMinutes_val - cap_user_attr_delayMinutes_val_no_value
}
*/
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r1_cond3 extends r1_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r1_cond4 extends r1_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1//cap_illuminanceMeasurement_attr_illuminance_val_Range1
}
one sig r2_cond3 extends r2_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_on
}
one sig r2_cond4 extends r2_cond {} {
  capabilities = app_SmartNightlightPlus.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0//cap_illuminanceMeasurement_attr_illuminance_val_Range0
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_pushed
  value        = cap_state_attr_pushed_val - cap_state_attr_pushed_val_pushed
}
/*
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_SmartNightlightPlus.user
  attribute    = cap_user_attr_delayMinutes
  value        = cap_user_attr_delayMinutes_val
}
*/
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_motionStopTime
  value = cap_state_attr_motionStopTime_val_null
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_motionStopTime
  value = cap_state_attr_motionStopTime_val
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_SmartNightlightPlus.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}


abstract sig r6_cond extends Condition {}


abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_pushed
  value = cap_state_attr_pushed_val_
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_pushed
  value        = cap_state_attr_pushed_val_pushed
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
/*
one sig r7_cond2 extends r7_cond {} {
  capabilities = app_SmartNightlightPlus.user
  attribute    = cap_user_attr_bigDelayMinutes
  value        = cap_user_attr_bigDelayMinutes_val
}
*/

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r8 extends r {}{
  triggers   = r8_trig
  conditions = r8_cond
  commands   = r8_comm
}

abstract sig r8_trig extends Trigger {}

one sig r8_trig0 extends r8_trig {} {
  capabilities = app_SmartNightlightPlus.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r8_cond extends Condition {}

one sig r8_cond0 extends r8_cond {} {
  capabilities = app_SmartNightlightPlus.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

abstract sig r8_comm extends Command {}

one sig r8_comm0 extends r8_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_pushed
  value = cap_state_attr_pushed_val_pushed
}

one sig r9 extends r {}{
  no triggers
  conditions = r9_cond
  commands   = r9_comm
}




abstract sig r9_cond extends Condition {}

one sig r9_cond0 extends r9_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r9_cond1 extends r9_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}
one sig r9_cond2 extends r9_cond {} {
  capabilities = app_SmartNightlightPlus.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r9_comm extends Command {}

one sig r9_comm0 extends r9_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
one sig r9_comm1 extends r9_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_off
}

one sig r10 extends r {}{
  triggers   = r10_trig
  conditions = r10_cond
  commands   = r10_comm
}

abstract sig r10_trig extends Trigger {}

one sig r10_trig0 extends r10_trig {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r10_cond extends Condition {}

one sig r10_cond0 extends r10_cond {} {
  capabilities = app_SmartNightlightPlus.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}

abstract sig r10_comm extends Command {}

one sig r10_comm0 extends r10_comm {} {
  capability   = app_SmartNightlightPlus.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}
one sig r10_comm1 extends r10_comm {} {
  capability   = app_SmartNightlightPlus.state
  attribute = cap_state_attr_lastStatus
  value = cap_state_attr_lastStatus_val_on
}



