module app_SmartLightController

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_illuminanceMeasurement
open cap_switch


one sig app_SmartLightController extends IoTApp {
  
  motionSensor : one cap_motionSensor,
  
  illuminanceSensor : one cap_illuminanceMeasurement,
  
  switches : some cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = motionSensor + illuminanceSensor + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_inactiveAt extends cap_state_attr {} {
  values = cap_state_attr_inactiveAt_val
}

abstract sig cap_state_attr_inactiveAt_val extends AttrValue {}
one sig cap_state_attr_inactiveAt_val_null extends cap_state_attr_inactiveAt_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SmartLightController.motionSensor
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SmartLightController.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_SmartLightController.motionSensor
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val - cap_motionSensor_attr_motion_val_active
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartLightController.state
  attribute    = cap_state_attr_inactiveAt
  value        = cap_state_attr_inactiveAt_val
}



