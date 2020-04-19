module app_MotionTriggersLock

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor
open cap_lock


one sig app_MotionTriggersLock extends IoTApp {
  
  motion1 : one cap_motionSensor,
  
  lock1 : some cap_lock,
} {
  rules = r
  //capabilities = motion1 + lock1
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_MotionTriggersLock.motion1
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_MotionTriggersLock.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MotionTriggersLock.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}



