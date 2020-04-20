module app_ID5

open IoTBottomUp as base

open cap_userInput
open cap_alarm
open cap_carbonMonoxideDetector
open cap_runIn

one sig app_ID5 extends IoTApp {
  
  phone : one cap_userInput,
  
  state : one cap_state,
  
  alarm : one cap_alarm,
  
  smoke : some cap_carbonMonoxideDetector,
  runIn : one cap_state,
} {
  rules = r
}


one sig cap_userInput_attr_phone extends cap_userInput_attr {}
{
    values = cap_userInput_attr_phone_val
} 
abstract sig cap_userInput_attr_phone_val extends cap_userInput_attr_value_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_msg extends cap_state_attr {} {
  values = cap_state_attr_msg_val
}

abstract sig cap_state_attr_msg_val extends AttrValue {}
one sig cap_state_attr_msg_val_CO_alarm extends cap_state_attr_msg_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID5.smoke
  attribute    = cap_carbonMonoxideDetector_attr_carbonMonoxide
  no value        //= cap_carbonMonoxideDetector_attr_carbonMonoxide_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID5.smoke
  attribute    = cap_carbonMonoxideDetector_attr_carbonMonoxide
  value        = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_clear
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ID5.smoke
  attribute    = cap_carbonMonoxideDetector_attr_carbonMonoxide
  value        = cap_carbonMonoxideDetector_attr_carbonMonoxide_val - cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID5.alarm
  attribute = cap_alarm_attr_alarm
  value = cap_alarm_attr_alarm_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID5.smoke
  attribute    = cap_carbonMonoxideDetector_attr_carbonMonoxide
  no value        //= cap_carbonMonoxideDetector_attr_carbonMonoxide_val
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID5.smoke
  attribute    = cap_carbonMonoxideDetector_attr_carbonMonoxide
  value        = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID5.alarm
  attribute = cap_alarm_attr_alarm
  value = cap_alarm_attr_alarm_val_strobe
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ID5.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ID5.alarm
  attribute    = cap_alarm_attr_alarm
  no value        //= cap_alarm_attr_alarm_val
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID5.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_strobe
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID5.state
  attribute = cap_state_attr_msg
  value = cap_state_attr_msg_val_CO_alarm
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_ID5.alarm
  attribute    = cap_alarm_attr_alarm
  no value        //= cap_alarm_attr_alarm_val
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_ID5.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_off
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_ID5.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val - cap_alarm_attr_alarm_val_strobe
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ID5.state
  attribute = cap_state_attr_msg
  value = cap_state_attr_msg_val_CO_alarm
}


one sig r4 extends r {}{
  no triggers
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_ID5.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability = app_ID5.smoke
  attribute  = cap_carbonMonoxideDetector_attr_carbonMonoxide
  value      = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected
}


