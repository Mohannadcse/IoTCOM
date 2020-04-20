module app_smoke_alert

open IoTBottomUp as base

open cap_smokeDetector
open cap_switch
open cap_lock


one sig app_smoke_alert extends IoTApp {
  
  smoke : some cap_smokeDetector,
  
  switch1 : one cap_switch,
  
  lock1 : one cap_lock,
} {
  rules = r
  //capabilities = smoke + switch1 + lock1
}






// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_smoke_alert.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_detected
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_smoke_alert.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_clear
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_smoke_alert.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val - cap_smokeDetector_attr_smoke_val_detected
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_smoke_alert.switch1
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
  capabilities = app_smoke_alert.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_detected
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_smoke_alert.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_detected
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_smoke_alert.switch1
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_smoke_alert.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_unlocked
}



