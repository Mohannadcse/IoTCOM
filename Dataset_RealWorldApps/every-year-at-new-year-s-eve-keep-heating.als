module app_every_year_at_new_year_s_eve_keep_heating

open IoTBottomUp as base

open cap_switch

lone sig app_every_year_at_new_year_s_eve_keep_heating extends IoTApp {
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
  capabilities = app_every_year_at_new_year_s_eve_keep_heating.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_every_year_at_new_year_s_eve_keep_heating.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



