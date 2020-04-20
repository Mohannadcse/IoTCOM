module app_ID1BrightenMyPath

open IoTBottomUp as base

open cap_motionSensor
open cap_switch


one sig app_ID1BrightenMyPath extends IoTApp {
  
  motion1 : some cap_motionSensor,
  
  switch1 : some cap_switch,
} {
  rules = r
}






// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions //= r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID1BrightenMyPath.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


//abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID1BrightenMyPath.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_ID1BrightenMyPath.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



