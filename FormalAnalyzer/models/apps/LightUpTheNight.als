module app_LightUpTheNight

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_illuminanceMeasurement
open cap_switch


one sig app_LightUpTheNight extends IoTApp {
  
  lightSensor : one cap_illuminanceMeasurement,
  
  lights : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = lightSensor + lights + state
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


one sig range_0,range_1,range_2 extends cap_illuminanceMeasurement_attr_illuminance_val {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_LightUpTheNight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_LightUpTheNight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_LightUpTheNight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_LightUpTheNight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  //value        = cap_illuminanceMeasurement_attr_illuminance_val_Range2
  value        = range_2
}
one sig r0_cond3 extends r0_cond {} {
  capabilities = app_LightUpTheNight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  //value        = cap_illuminanceMeasurement_attr_illuminance_val_Range1
  value        = range_1
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LightUpTheNight.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_LightUpTheNight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_LightUpTheNight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_LightUpTheNight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_on
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_LightUpTheNight.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  //value        = cap_illuminanceMeasurement_attr_illuminance_val_Range0
  value        = range_0
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LightUpTheNight.lights
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_LightUpTheNight.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}



