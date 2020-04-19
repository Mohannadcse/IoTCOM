module app_ChangeModeWhenItIsDark

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_illuminanceMeasurement

open cap_location

one sig app_ChangeModeWhenItIsDark extends IoTApp {
  location : one cap_location,
  
  sensors : some cap_illuminanceMeasurement,
  
  state : one cap_state,
  
  newMode : one cap_location_attr_mode_val,
} {
  rules = r
  //capabilities = sensors + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ChangeModeWhenItIsDark.sensors
  attribute    = cap_illuminanceMeasurement_attr_illuminance
  no value
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ChangeModeWhenItIsDark.location
  attribute    = cap_location_attr_mode
  value        = app_ChangeModeWhenItIsDark.newMode
}



