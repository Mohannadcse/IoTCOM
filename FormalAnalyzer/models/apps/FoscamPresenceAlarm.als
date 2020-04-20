module app_FoscamPresenceAlarm

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_imageCapture
open cap_presenceSensor

open cap_app

one sig app_FoscamPresenceAlarm extends IoTApp {
  app : one cap_app,  
  cameras : some cap_imageCapture,
  
  presence : some cap_presenceSensor,
  
  //startTime : one cap_userInput,
  
  //buttonMode : one cap_userInput,
} {
  rules = r
  //capabilities = cameras + presence + startTime + buttonMode + app
}
/*
abstract sig cap_userInput_attr_value_startTimeVal extends cap_userInput_attr_value_val {}
one sig startTimeVal0, startTimeVal1 extends cap_userInput_attr_value_startTimeVal {}
abstract sig cap_userInput_attr_value_buttonModeVal extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_buttonMode_val_Enable_Alarm extends cap_userInput_attr_value_buttonModeVal {}
one sig cap_userInput_attr_buttonMode_val_Disable_Alarm extends cap_userInput_attr_value_buttonModeVal {}
*/

one sig cap_imageCapture_attr_image_val_alarmOn extends cap_imageCapture_attr_image_val {}
one sig cap_imageCapture_attr_image_val_alarmOff extends cap_imageCapture_attr_image_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}
/*
one sig r0_cond0 extends r0_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_startTime
  value        = cap_user_attr_startTime_val_
}
*/
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value        //= cap_presenceSensor_attr_presence_val_null
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOn
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}
/*
one sig r1_cond0 extends r1_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_startTime
  value        = cap_user_attr_startTime_val_
}
*/
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value        //= cap_presenceSensor_attr_presence_val_null
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOn
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
/*
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_startTime
  value        = cap_user_attr_startTime_val_
}
*/
abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOff
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_FoscamPresenceAlarm.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
/*
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_startTime
  value        = cap_user_attr_startTime_val_
}
*/

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOff
}

one sig r4 extends r {}{
  triggers   = r4_trig
  no conditions// = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_FoscamPresenceAlarm.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}

/*
abstract sig r4_cond extends Condition {}

one sig r4_cond0 extends r4_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_buttonMode
  value        = cap_user_attr_buttonMode_val_Enable Alarm
}
*/

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOn
}

one sig r5 extends r {}{
  triggers   = r5_trig
  no conditions //= r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_FoscamPresenceAlarm.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}

/*
abstract sig r5_cond extends Condition {}

one sig r5_cond0 extends r5_cond {} {
  capabilities = app_FoscamPresenceAlarm.user
  attribute    = cap_user_attr_buttonMode
  value        = cap_user_attr_buttonMode_val - cap_user_attr_buttonMode_val_Enable Alarm
}
*/
abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_FoscamPresenceAlarm.cameras
  attribute    = cap_imageCapture_attr_image
  value        = cap_imageCapture_attr_image_val_alarmOff
}



