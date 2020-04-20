module app_ID12RemoteCommand

open IoTBottomUp as base

open cap_smokeDetector
open cap_alarm


one sig app_ID12RemoteCommand extends IoTApp {
  
  smoke : one cap_smokeDetector,
  
  alarm : one cap_alarm,
} {
  rules = r
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
  capabilities = app_ID12RemoteCommand.smoke
  attribute    = cap_smokeDetector_attr_smoke
  no value
  //value        = cap_smokeDetector_attr_smoke_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID12RemoteCommand.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_detected
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID12RemoteCommand.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_strobe
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID12RemoteCommand.smoke
  attribute    = cap_smokeDetector_attr_smoke
  no value
  //value        = cap_smokeDetector_attr_smoke_val
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID12RemoteCommand.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val - cap_smokeDetector_attr_smoke_val_detected
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_ID12RemoteCommand.smoke
  attribute    = cap_smokeDetector_attr_smoke
  value        = cap_smokeDetector_attr_smoke_val_clear
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID12RemoteCommand.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_off
}



