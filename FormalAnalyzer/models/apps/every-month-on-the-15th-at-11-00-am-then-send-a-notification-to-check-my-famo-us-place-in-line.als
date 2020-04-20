module app_every_month_on_the_15th_at_11_00_am_then_send_a_notification_to_check_my_famo_us_place_in_line

open IoTBottomUp as base

open cap_switch

lone sig app_every_month_on_the_15th_at_11_00_am_then_send_a_notification_to_check_my_famo_us_place_in_line extends IoTApp {
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
  capabilities = app_every_month_on_the_15th_at_11_00_am_then_send_a_notification_to_check_my_famo_us_place_in_line.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_every_month_on_the_15th_at_11_00_am_then_send_a_notification_to_check_my_famo_us_place_in_line.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



