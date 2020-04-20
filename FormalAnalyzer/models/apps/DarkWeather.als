module app_DarkWeather

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_waterSensor
open cap_switch

open cap_location

one sig app_DarkWeather extends IoTApp {
  location : one cap_location,
  sensor : one cap_waterSensor,
  switches : some cap_switch,
  state : one cap_state,
  clearMode : one cap_location_attr_mode_val,
  rainMode : one cap_location_attr_mode_val
} {
  rules = r
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
  capabilities = app_DarkWeather.sensor
  attribute    = cap_waterSensor_attr_water
  no value
}

abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_DarkWeather.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_DarkWeather.clearMode
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_DarkWeather.location
  attribute    = cap_location_attr_sunSet
  value        = cap_location_attr_sunSet_val_ON
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DarkWeather.location
  attribute    = cap_location_attr_mode
  value        = app_DarkWeather.clearMode
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_DarkWeather.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_DarkWeather.sensor
  attribute    = cap_waterSensor_attr_water
  no value
}

abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DarkWeather.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_DarkWeather.rainMode
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DarkWeather.location
  attribute    = cap_location_attr_mode
  value        = app_DarkWeather.rainMode
}
