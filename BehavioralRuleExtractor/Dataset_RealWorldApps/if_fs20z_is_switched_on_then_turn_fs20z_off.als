module app_if_fs20z_is_switched_on_then_turn_fs20z_off

open IoTBottomUp as base

open cap_switch

one sig app_if_fs20z_is_switched_on_then_turn_fs20z_off extends IoTApp {
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
  capabilities = app_if_fs20z_is_switched_on_then_turn_fs20z_off.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_fs20z_is_switched_on_then_turn_fs20z_off.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



