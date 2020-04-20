module app_PowerIsOut

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_motionSensor

open cap_userInput

one sig app_PowerIsOut extends IoTApp {
  
  motion1 : one cap_motionSensor,
  
  phone1 : one cap_userInput,
} {
  rules = r
  //capabilities = motion1 + phone1
}

abstract sig cap_userInput_attr_phone1_val extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_phone1_val0 extends cap_userInput_attr_phone1_val {}





abstract sig r extends Rule {}



