module app_turns_off_a_wemo_switch_when_presence_is_no_longer_detected_in_smartthings

open IoTBottomUp as base

open cap_presenceSensor
open cap_switch

lone sig app_turns_off_a_wemo_switch_when_presence_is_no_longer_detected_in_smartthings extends IoTApp {
  trigObj : one cap_presenceSensor,
  switch : one cap_switch,
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
  capabilities = app_turns_off_a_wemo_switch_when_presence_is_no_longer_detected_in_smartthings.trigObj
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turns_off_a_wemo_switch_when_presence_is_no_longer_detected_in_smartthings.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



