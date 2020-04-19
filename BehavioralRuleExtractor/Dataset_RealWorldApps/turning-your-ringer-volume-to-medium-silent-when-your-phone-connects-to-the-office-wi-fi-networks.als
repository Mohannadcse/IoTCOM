module app_turning_your_ringer_volume_to_medium_silent_when_your_phone_connects_to_the_office_wi_fi_networks

open IoTBottomUp as base

open cap_switch

lone sig app_turning_your_ringer_volume_to_medium_silent_when_your_phone_connects_to_the_office_wi_fi_networks extends IoTApp {
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
  capabilities = app_turning_your_ringer_volume_to_medium_silent_when_your_phone_connects_to_the_office_wi_fi_networks.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turning_your_ringer_volume_to_medium_silent_when_your_phone_connects_to_the_office_wi_fi_networks.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



