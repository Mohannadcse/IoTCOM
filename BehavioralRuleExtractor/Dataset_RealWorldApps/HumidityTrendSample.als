module app_HumidityTrendSample

open IoTBottomUp as base

open cap_relativeHumidityMeasurement


one sig app_HumidityTrendSample extends IoTApp {
  
  state : one cap_state,
  
  humidity : one cap_relativeHumidityMeasurement,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_mode extends cap_state_attr {} {
  values = cap_state_attr_mode_val
}

abstract sig cap_state_attr_mode_val extends AttrValue {}
one sig cap_state_attr_mode_val_newModeUp extends cap_state_attr_mode_val {}
one sig cap_state_attr_mode_val_newModeDown extends cap_state_attr_mode_val {}

one sig cap_state_attr_humidityThresholdActivated extends cap_state_attr {} {
  values = cap_state_attr_humidityThresholdActivated_val
}

abstract sig cap_state_attr_humidityThresholdActivated_val extends AttrValue {}
one sig cap_state_attr_humidityThresholdActivated_val_false extends cap_state_attr_humidityThresholdActivated_val {}
one sig cap_state_attr_humidityThresholdActivated_val_true extends cap_state_attr_humidityThresholdActivated_val {}

one sig cap_state_attr_currentTrend extends cap_state_attr {} {
  values = cap_state_attr_currentTrend_val
}

abstract sig cap_state_attr_currentTrend_val extends AttrValue {}
one sig cap_state_attr_currentTrend_val_UP extends cap_state_attr_currentTrend_val {}
one sig cap_state_attr_currentTrend_val_DOWN extends cap_state_attr_currentTrend_val {}
one sig cap_state_attr_currentTrend_val_NONE extends cap_state_attr_currentTrend_val {}

one sig cap_state_attr_currentTrendPts extends cap_state_attr {} {
  values = cap_state_attr_currentTrendPts_val
}

abstract sig cap_state_attr_currentTrendPts_val extends AttrValue {}
one sig cap_state_attr_currentTrendPts_val_ extends cap_state_attr_currentTrendPts_val {}
one sig cap_state_attr_currentTrendPts_val_0 extends cap_state_attr_currentTrendPts_val {}

one sig cap_state_attr_lastHumidity extends cap_state_attr {} {
  values = cap_state_attr_lastHumidity_val
}

abstract sig cap_state_attr_lastHumidity_val extends AttrValue {}
one sig cap_state_attr_lastHumidity_val_0 extends cap_state_attr_lastHumidity_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_HumidityTrendSample.humidity
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val//_lte_(0_-_settings.humidity2)
}
/*
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val_lt_settings.humidity1
}
*/
one sig r0_cond2 extends r0_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_humidityThresholdActivated
  value        = cap_state_attr_humidityThresholdActivated_val_false
}
one sig r0_cond3 extends r0_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val - cap_state_attr_currentTrend_val_NONE
}
one sig r0_cond4 extends r0_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val - cap_state_attr_currentTrend_val_UP
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HumidityTrendSample.state
  attribute = cap_state_attr_lastHumidity
  value = cap_state_attr_lastHumidity_val//_not_null
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_HumidityTrendSample.humidity
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val//_gte_settings.humidity1
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val_NONE
}
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val_UP
}
one sig r1_cond3 extends r1_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_humidityThresholdActivated
  value        = cap_state_attr_humidityThresholdActivated_val_true
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_HumidityTrendSample.state
  attribute = cap_state_attr_lastHumidity
  value = cap_state_attr_lastHumidity_val//_not_null
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_HumidityTrendSample.humidity
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val//_gte_settings.humidity1
}
one sig r2_cond1 extends r2_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val_NONE
}
one sig r2_cond2 extends r2_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val_UP
}
one sig r2_cond3 extends r2_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_humidityThresholdActivated
  value        = cap_state_attr_humidityThresholdActivated_val_true
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_HumidityTrendSample.state
  attribute = cap_state_attr_humidityThresholdActivated
  value = cap_state_attr_humidityThresholdActivated_val_true
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_HumidityTrendSample.humidity
  attribute    = cap_relativeHumidityMeasurement_attr_humidity
  no value
}


abstract sig r3_cond extends Condition {}

one sig r3_cond0 extends r3_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val//_lte_(0_-_settings.humidity2)
}
/*
one sig r3_cond1 extends r3_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrendPts
  value        = cap_state_attr_currentTrendPts_val_lt_settings.humidity1
}
*/
one sig r3_cond2 extends r3_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_humidityThresholdActivated
  value        = cap_state_attr_humidityThresholdActivated_val_false
}
one sig r3_cond3 extends r3_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val - cap_state_attr_currentTrend_val_NONE
}
one sig r3_cond4 extends r3_cond {} {
  capabilities = app_HumidityTrendSample.state
  attribute    = cap_state_attr_currentTrend
  value        = cap_state_attr_currentTrend_val - cap_state_attr_currentTrend_val_UP
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_HumidityTrendSample.state
  attribute = cap_state_attr_humidityThresholdActivated
  value = cap_state_attr_humidityThresholdActivated_val_false
}



