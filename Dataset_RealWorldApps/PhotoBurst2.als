module app_PhotoBurst2

open IoTBottomUp as base

open cap_motionSensor
open cap_accelerationSensor
open cap_switch
open cap_imageCapture
open cap_contactSensor
open cap_presenceSensor
open cap_userInput

one sig app_PhotoBurst2 extends IoTApp {
  
  motion : some cap_motionSensor,
  
  departurePresence : some cap_presenceSensor,
  
  acceleration : some cap_accelerationSensor,
  
  mySwitch : some cap_switch,
  
  contact : some cap_contactSensor,
  
  arrivalPresence : some cap_presenceSensor,
  user : one cap_userInput,
  camera : one cap_imageCapture,
} {
  rules = r
}


one sig cap_userInput_attr_phone extends cap_userInput_attr {} {
  values = cap_userInput_attr_phone_val
}

one sig cap_userInput_attr_phone_val extends AttrValue {}


one sig cap_imageCapture_attr_image_val_take extends AttrValue {}

// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_PhotoBurst2.arrivalPresence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_PhotoBurst2.mySwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_trig2 extends r0_trig {} {
  capabilities = app_PhotoBurst2.acceleration
  attribute    = cap_accelerationSensor_attr_acceleration
  value        = cap_accelerationSensor_attr_acceleration_val_active
}
one sig r0_trig3 extends r0_trig {} {
  capabilities = app_PhotoBurst2.motion
  attribute    = cap_motionSensor_attr_motion
  value        = cap_motionSensor_attr_motion_val_active
}
one sig r0_trig4 extends r0_trig {} {
  capabilities = app_PhotoBurst2.departurePresence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}
one sig r0_trig5 extends r0_trig {} {
  capabilities = app_PhotoBurst2.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_PhotoBurst2.user
  attribute    = cap_userInput_attr_phone
  value        = cap_userInput_attr_phone_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_PhotoBurst2.camera
  attribute = cap_imageCapture_attr_image
  value = cap_imageCapture_attr_image_val_take
}



