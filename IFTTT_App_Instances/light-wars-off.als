module app_light-wars-off

open IoTBottomUp as base

open cap_illuminanceMeasurement
open cap_switch

lone sig app_light-wars-off extends IoTApp {
  trigObj : one cap_illuminanceMeasurement,
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
  capabilities = app_light-wars-off.trigObj
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  value        = cap_illuminanceMeasurement_attr_illuminance_val_range_0
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_light-wars-off.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



