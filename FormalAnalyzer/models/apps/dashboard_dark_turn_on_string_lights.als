module app_dashboard_dark_turn_on_string_lights

open IoTBottomUp as base

open cap_illuminanceMeasurement
open cap_switch

one sig app_dashboard_dark_turn_on_string_lights extends IoTApp {
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
  capabilities = app_dashboard_dark_turn_on_string_lights.trigObj
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = range_0
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_dashboard_dark_turn_on_string_lights.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



