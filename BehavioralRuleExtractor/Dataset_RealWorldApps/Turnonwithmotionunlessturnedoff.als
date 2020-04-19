module app_Turnonwithmotionunlessturnedoff

open IoTBottomUp as base

open cap_motionSensor
open cap_switch


one sig app_Turnonwithmotionunlessturnedoff extends IoTApp {
  
  switchLight : one cap_switch,
  
  motion : one cap_motionSensor,
  
  state : one cap_state,
  
  lights : some cap_switch,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_runOff extends cap_state_attr {} {
  values = cap_state_attr_runOff_val
}

abstract sig cap_state_attr_runOff_val extends AttrValue {}
one sig cap_state_attr_runOff_val_true extends cap_state_attr_runOff_val {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}

one sig cap_state_attr_enabled extends cap_state_attr {} {
  values = cap_state_attr_enabled_val
}

abstract sig cap_state_attr_enabled_val extends AttrValue {}
one sig cap_state_attr_enabled_val_true extends cap_state_attr_enabled_val {}
one sig cap_state_attr_enabled_val_false extends cap_state_attr_enabled_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.motion
  attribute    = cap_motionSensor_attr_motion
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.state
  attribute    = cap_state_attr_enabled
  value        = cap_state_attr_enabled_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_Turnonwithmotionunlessturnedoff.lights
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_Turnonwithmotionunlessturnedoff.state
  attribute = cap_state_attr_enabled
  value = cap_state_attr_enabled_val_true
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.switchLight
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_Turnonwithmotionunlessturnedoff.switchLight
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_Turnonwithmotionunlessturnedoff.state
  attribute = cap_state_attr_enabled
  value = cap_state_attr_enabled_val_false
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_Turnonwithmotionunlessturnedoff.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



