module app_alarm_clock_for_travel_change_the_date_when_you_want_to_be_called_or_it_ll_call_you_every_year

open IoTBottomUp as base

open cap_switch

lone sig app_alarm_clock_for_travel_change_the_date_when_you_want_to_be_called_or_it_ll_call_you_every_year extends IoTApp {
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
  capabilities = app_alarm_clock_for_travel_change_the_date_when_you_want_to_be_called_or_it_ll_call_you_every_year.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_alarm_clock_for_travel_change_the_date_when_you_want_to_be_called_or_it_ll_call_you_every_year.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



