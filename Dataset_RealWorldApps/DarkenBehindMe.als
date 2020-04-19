module app_DarkenBehindMe

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_switch


one sig app_DarkenBehindMe extends IoTApp {
  
  motion1 : one cap_motionSensor,
  
  switch1 : one cap_switch,
} {
  rules = r
  //capabilities = motion1 + switch1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_DarkenBehindMe.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_inactive
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DarkenBehindMe.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



