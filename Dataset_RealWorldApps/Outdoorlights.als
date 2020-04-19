module app_Outdoorlights

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch
open cap_illuminanceMeasurement

open cap_userInput

one sig app_Outdoorlights extends IoTApp {
  
  contact1 : some cap_contactSensor,
  
  switches : some cap_switch,
  
  lightSensor : one cap_illuminanceMeasurement,
  
  time : one cap_userInput,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + switches + lightSensor + time + state
}

abstract sig cap_userInput_attr_time_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_time_val0 extends cap_userInput_attr_time_val {}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_lastStatus extends cap_state_attr {} {
  values = cap_state_attr_lastStatus_val
}

abstract sig cap_state_attr_lastStatus_val extends AttrValue {}
one sig cap_state_attr_lastStatus_val_on extends cap_state_attr_lastStatus_val {}
one sig cap_state_attr_lastStatus_val_off extends cap_state_attr_lastStatus_val {}

one sig cap_state_attr_motionStopTime extends cap_state_attr {} {
  values = cap_state_attr_motionStopTime_val
}
abstract sig cap_state_attr_motionStopTime_val extends AttrValue {}
//one sig cap_state_attr_lastStatus_val_on extends cap_state_attr_lastStatus_val {}


abstract sig cap_user_attr_time extends cap_userInput_attr {}
{
    values = cap_user_attr_time_val
} 

abstract sig cap_user_attr_time_val extends cap_userInput_attr_value_val {}
one sig cap_user_attr_time_val_0 extends cap_user_attr_time_val {}


one sig range_0,range_1,range_2 extends cap_illuminanceMeasurement_attr_illuminance_val {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_Outdoorlights.switches
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
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_2//cap_illuminanceMeasurement_attr_illuminance_val_Range2
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}
/*
one sig r2_trig0 extends r2_trig {} {
  capabilities = app_Outdoorlights.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_openening
}
*/
one sig r2_trig1 extends r2_trig {} {
  capabilities = app_Outdoorlights.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_Outdoorlights.time
  attribute    = cap_user_attr_time
  value        = cap_user_attr_time_val - cap_user_attr_time_val_0
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_Outdoorlights.state
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
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_off
}
one sig r3_cond3 extends r3_cond {} {
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1
}
one sig r3_cond4 extends r3_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}
/*
one sig r4_trig0 extends r4_trig {} {
  capabilities = app_Outdoorlights.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_openening
}
*/
one sig r4_trig1 extends r4_trig {} {
  capabilities = app_Outdoorlights.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r4_cond extends Condition {}


abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_Outdoorlights.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
/*
one sig r5 extends r {}{
  no triggers
  conditions = r5_cond
  commands   = r5_comm
}




abstract sig r5_cond extends Condition {}


abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_Outdoorlights.state
  attribute    = cap_state_attr_riseTime
  value        = cap_state_attr_riseTime_val
}
one sig r5_comm1 extends r5_comm {} {
  capability   = app_Outdoorlights.state
  attribute    = cap_state_attr_setTime
  value        = cap_state_attr_setTime_val
}
*/
one sig r6 extends r {}{
  triggers   = r6_trig
  conditions = r6_cond
  commands   = r6_comm
}

abstract sig r6_trig extends Trigger {}

one sig r6_trig0 extends r6_trig {} {
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r6_cond extends Condition {}

one sig r6_cond0 extends r6_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_off
}
one sig r6_cond1 extends r6_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}
one sig r6_cond2 extends r6_cond {} {
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1
}
one sig r6_cond3 extends r6_cond {} {
  capabilities = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val - cap_state_attr_lastStatus_val_on
}
one sig r6_cond4 extends r6_cond {} {
  capabilities = app_Outdoorlights.lightSensor
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0
}

abstract sig r6_comm extends Command {}

one sig r6_comm0 extends r6_comm {} {
  capability   = app_Outdoorlights.state
  attribute    = cap_state_attr_lastStatus
  value        = cap_state_attr_lastStatus_val_on
}



