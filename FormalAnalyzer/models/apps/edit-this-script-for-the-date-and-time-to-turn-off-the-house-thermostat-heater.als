module app_edit_this_script_for_the_date_and_time_to_turn_off_the_house_thermostat_heater

open IoTBottomUp as base

open cap_switch

lone sig app_edit_this_script_for_the_date_and_time_to_turn_off_the_house_thermostat_heater extends IoTApp {
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
  capabilities = app_edit_this_script_for_the_date_and_time_to_turn_off_the_house_thermostat_heater.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_edit_this_script_for_the_date_and_time_to_turn_off_the_house_thermostat_heater.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



