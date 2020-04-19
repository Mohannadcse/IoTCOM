module app_AutoHumidityVent

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_relativeHumidityMeasurement
open cap_switch
open cap_energyMeter


one sig app_AutoHumidityVent extends IoTApp {
  
  humidity_sensor : one cap_relativeHumidityMeasurement,
  
  fans : set cap_switch,
  
  emeters : some cap_energyMeter,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = humidity_sensor + fans + emeters + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_fansLastRunTime extends cap_state_attr {} {
  values = cap_state_attr_fansLastRunTime_val
}

abstract sig cap_state_attr_fansLastRunTime_val extends AttrValue {}
one sig cap_state_attr_fansLastRunTime_val_0 extends cap_state_attr_fansLastRunTime_val {}
one sig cap_state_attr_fansLastRunTime_val_ extends cap_state_attr_fansLastRunTime_val {}

one sig cap_state_attr_fansLastRunCost extends cap_state_attr {} {
  values = cap_state_attr_fansLastRunCost_val
}

abstract sig cap_state_attr_fansLastRunCost_val extends AttrValue {}
one sig cap_state_attr_fansLastRunCost_val_ extends cap_state_attr_fansLastRunCost_val {}

one sig cap_state_attr_app_enabled extends cap_state_attr {} {
  values = cap_state_attr_app_enabled_val
}

abstract sig cap_state_attr_app_enabled_val extends AttrValue {}
one sig cap_state_attr_app_enabled_val_false extends cap_state_attr_app_enabled_val {}
one sig cap_state_attr_app_enabled_val_true extends cap_state_attr_app_enabled_val {}

one sig cap_state_attr_fan_control_enabled extends cap_state_attr {} {
  values = cap_state_attr_fan_control_enabled_val
}

abstract sig cap_state_attr_fan_control_enabled_val extends AttrValue {}
one sig cap_state_attr_fan_control_enabled_val_false extends cap_state_attr_fan_control_enabled_val {}
one sig cap_state_attr_fan_control_enabled_val_true extends cap_state_attr_fan_control_enabled_val {}

one sig cap_state_attr_fansOn extends cap_state_attr {} {
  values = cap_state_attr_fansOn_val
}

abstract sig cap_state_attr_fansOn_val extends AttrValue {}
one sig cap_state_attr_fansOn_val_false extends cap_state_attr_fansOn_val {}
one sig cap_state_attr_fansOn_val_true extends cap_state_attr_fansOn_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_AutoHumidityVent.humidity_sensor
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansOn
  value        = cap_state_attr_fansOn_val_false
}

abstract sig r0_comm extends Command {}
/*
one sig r0_comm0 extends r0_comm {} {
  capability   = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansOnTime
  value        = cap_state_attr_fansOnTime_val_not_null
}
*/
one sig r0_comm1 extends r0_comm {} {
  capability   = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansOn
  value        = cap_state_attr_fansOn_val_true
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_AutoHumidityVent.humidity_sensor
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansOn
  value        = cap_state_attr_fansOn_val_true
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansLastRunTime
  value        = cap_state_attr_fansLastRunTime_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansOn
  value        = cap_state_attr_fansOn_val_false
}
/*
one sig r1_comm2 extends r1_comm {} {
  capability   = app_AutoHumidityVent.state
  attribute    = cap_state_attr_fansHoldoff
  value        = cap_state_attr_fansHoldoff_val
}
*/



