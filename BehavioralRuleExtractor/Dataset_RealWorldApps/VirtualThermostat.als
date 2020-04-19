module app_VirtualThermostat

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_temperatureMeasurement
open cap_switch
open cap_motionSensor
open cap_userInput


one sig app_VirtualThermostat extends IoTApp {
  
  sensor : one cap_temperatureMeasurement,
  
  outlets : some cap_switch,
  
  motion : one cap_motionSensor,
  
  mode : one cap_userInput,
} {
  rules = r
  //capabilities = sensor + outlets + motion + mode
}

one sig cap_userInput_attr_mode extends cap_userInput_attr {} {
  values = cap_userInput_attr_mode_val
}


abstract sig cap_userInput_attr_mode_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_mode_val_heat extends cap_userInput_attr_mode_val {}
one sig cap_userInput_attr_mode_val_cool extends cap_userInput_attr_mode_val {}





abstract sig r extends Rule {}

one sig r11 extends r {}{
  triggers   = r11_trig
  conditions = r11_cond
  commands   = r11_comm
}

abstract sig r11_trig extends Trigger {}

one sig r11_trig0 extends r11_trig {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r11_cond extends Condition {}

one sig r11_cond0 extends r11_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}

abstract sig r11_comm extends Command {}

one sig r11_comm0 extends r11_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r12 extends r {}{
  triggers   = r12_trig
  conditions = r12_cond
  commands   = r12_comm
}

abstract sig r12_trig extends Trigger {}

one sig r12_trig0 extends r12_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r12_cond extends Condition {}

one sig r12_cond0 extends r12_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r12_cond1 extends r12_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r12_cond2 extends r12_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}
one sig r12_cond3 extends r12_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val
}

abstract sig r12_comm extends Command {}

one sig r12_comm0 extends r12_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r13 extends r {}{
  triggers   = r13_trig
  conditions = r13_cond
  commands   = r13_comm
}

abstract sig r13_trig extends Trigger {}

one sig r13_trig0 extends r13_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r13_cond extends Condition {}

one sig r13_cond0 extends r13_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r13_cond1 extends r13_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}
one sig r13_cond2 extends r13_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val 
}

abstract sig r13_comm extends Command {}

one sig r13_comm0 extends r13_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_VirtualThermostat.outlets
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
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_VirtualThermostat.outlets
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
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}
one sig r3_cond3 extends r3_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val 
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r5_cond1 extends r5_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}
one sig r5_cond2 extends r5_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r5_cond3 extends r5_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val 
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r6_cond extends Condition {}


abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r7 extends r {}{
  triggers   = r7_trig
  conditions = r7_cond
  commands   = r7_comm
}

abstract sig r7_trig extends Trigger {}

one sig r7_trig0 extends r7_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r7_cond extends Condition {}

one sig r7_cond0 extends r7_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r7_cond1 extends r7_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val_cool
}
one sig r7_cond2 extends r7_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val 
}

abstract sig r7_comm extends Command {}

one sig r7_comm0 extends r7_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}

one sig r8 extends r {}{
  triggers   = r8_trig
  conditions = r8_cond
  commands   = r8_comm
}

abstract sig r8_trig extends Trigger {}

one sig r8_trig0 extends r8_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r8_cond extends Condition {}

one sig r8_cond0 extends r8_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r8_cond1 extends r8_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}

abstract sig r8_comm extends Command {}

one sig r8_comm0 extends r8_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r9 extends r {}{
  triggers   = r9_trig
  conditions = r9_cond
  commands   = r9_comm
}

abstract sig r9_trig extends Trigger {}

one sig r9_trig0 extends r9_trig {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r9_cond extends Condition {}

one sig r9_cond0 extends r9_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}
one sig r9_cond1 extends r9_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}
one sig r9_cond2 extends r9_cond {} {
  capabilities = app_VirtualThermostat.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r9_cond3 extends r9_cond {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val 
}

abstract sig r9_comm extends Command {}

one sig r9_comm0 extends r9_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r10 extends r {}{
  triggers   = r10_trig
  conditions = r10_cond
  commands   = r10_comm
}

abstract sig r10_trig extends Trigger {}

one sig r10_trig0 extends r10_trig {} {
  capabilities = app_VirtualThermostat.sensor
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r10_cond extends Condition {}

one sig r10_cond0 extends r10_cond {} {
  capabilities = app_VirtualThermostat.mode
  attribute    = cap_userInput_attr_mode
  value        = cap_userInput_attr_mode_val - cap_userInput_attr_mode_val_cool
}

abstract sig r10_comm extends Command {}

one sig r10_comm0 extends r10_comm {} {
  capability   = app_VirtualThermostat.outlets
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



