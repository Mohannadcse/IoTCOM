module app_if_its_bright_turn_off_the_light

open IoTBottomUp as base

open cap_illuminanceMeasurement
open cap_switch

one sig app_if_its_bright_turn_off_the_light extends IoTApp {
  trigObj : one cap_illuminanceMeasurement,
  switch : one cap_switch,
} {
  rules = r
}

one sig range_0, range_1 extends cap_illuminanceMeasurement_attr_illuminance_val {}

// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_if_its_bright_turn_off_the_light.trigObj
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_1
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_its_bright_turn_off_the_light.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



