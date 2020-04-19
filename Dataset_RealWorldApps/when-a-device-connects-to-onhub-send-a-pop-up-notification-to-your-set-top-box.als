module app_when_a_device_connects_to_onhub_send_a_pop_up_notification_to_your_set_top_box

open IoTBottomUp as base

open cap_switch

lone sig app_when_a_device_connects_to_onhub_send_a_pop_up_notification_to_your_set_top_box extends IoTApp {
  trigObj : one cap_switch,
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
  capabilities = app_when_a_device_connects_to_onhub_send_a_pop_up_notification_to_your_set_top_box.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_when_a_device_connects_to_onhub_send_a_pop_up_notification_to_your_set_top_box.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



