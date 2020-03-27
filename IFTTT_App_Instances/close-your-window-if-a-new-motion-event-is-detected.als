module app_close-your-window-if-a-new-motion-event-is-detected

open IoTBottomUp as base

open cap_lock
open cap_motionSensor

lone sig app_close-your-window-if-a-new-motion-event-is-detected extends IoTApp {
  trigObj : one cap_motionSensor,
} {
  rules = r
}


// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_close-your-window-if-a-new-motion-event-is-detected.trigObj
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_close-your-window-if-a-new-motion-event-is-detected.lock
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_lock
}



