module app_CloseTheValve

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_waterSensor
open cap_valve


one sig app_CloseTheValve extends IoTApp {
  
  sensor : set cap_waterSensor,
  
  valve : one cap_valve,
} {
  rules = r
  //capabilities = sensor + valve
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_CloseTheValve.sensor
  attribute    = cap_waterSensor_attr_water
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_CloseTheValve.sensor
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_CloseTheValve.valve
  attribute    = cap_valve_attr_valve
  value        = cap_valve_attr_valve_val_closed
}



