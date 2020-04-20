module app_send_notification_when_the_outside_temp_warms_up_so_i_can_close_windows_and_turn_on_ac

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

lone sig app_send_notification_when_the_outside_temp_warms_up_so_i_can_close_windows_and_turn_on_ac extends IoTApp {
  trigObj : one cap_temperatureMeasurement,
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
  capabilities = app_send_notification_when_the_outside_temp_warms_up_so_i_can_close_windows_and_turn_on_ac.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_low
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_send_notification_when_the_outside_temp_warms_up_so_i_can_close_windows_and_turn_on_ac.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



