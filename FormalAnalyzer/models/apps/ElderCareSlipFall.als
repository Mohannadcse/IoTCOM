module app_ElderCareSlipFall

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor


one sig app_ElderCareSlipFall extends IoTApp {
  
  bedroomMotion : some cap_motionSensor,
  
  bathroomMotion : one cap_motionSensor,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = bedroomMotion + bathroomMotion + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_active extends cap_state_attr {} {
  values = cap_state_attr_active_val
}

abstract sig cap_state_attr_active_val extends AttrValue {}
one sig cap_state_attr_active_val_0 extends cap_state_attr_active_val {}


one sig cap_state_attr_status extends cap_state_attr {} {
  values = cap_state_attr_status_val
}

abstract sig cap_state_attr_status_val extends AttrValue {}
one sig cap_state_attr_status_val_null extends cap_state_attr_status_val {}
one sig cap_state_attr_status_val_waiting extends cap_state_attr_status_val {}
one sig cap_state_attr_status_val_pending extends cap_state_attr_status_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ElderCareSlipFall.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_null
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ElderCareSlipFall.bedroomMotion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val - cap_state_attr_status_val_waiting
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_pending
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ElderCareSlipFall.bathroomMotion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_pending
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_waiting
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_ElderCareSlipFall.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_ElderCareSlipFall.bedroomMotion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_waiting
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ElderCareSlipFall.state
  attribute    = cap_state_attr_status
  value        = cap_state_attr_status_val_null
}



