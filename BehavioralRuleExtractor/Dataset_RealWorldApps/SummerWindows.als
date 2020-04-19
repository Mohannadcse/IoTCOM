module app_SummerWindows

open IoTBottomUp as base

open cap_temperatureMeasurement


one sig app_SummerWindows extends IoTApp {
  
  temperatureSensorOut : one cap_temperatureMeasurement,
  
  state : one cap_state,
  
  temperatureSensorIn : one cap_temperatureMeasurement,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_windows extends cap_state_attr {} {
  values = cap_state_attr_windows_val
}

abstract sig cap_state_attr_windows_val extends AttrValue {}
one sig cap_state_attr_windows_val_open extends cap_state_attr_windows_val {}
one sig cap_state_attr_windows_val_closed extends cap_state_attr_windows_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SummerWindows.temperatureSensorIn
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SummerWindows.state
  attribute    = cap_state_attr_windows
  value        = cap_state_attr_windows_val - cap_state_attr_windows_val_closed
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SummerWindows.state
  attribute = cap_state_attr_windows
  value = cap_state_attr_windows_val_closed
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SummerWindows.temperatureSensorIn
  attribute    = cap_temperatureMeasurement_attr_temperature
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SummerWindows.state
  attribute    = cap_state_attr_windows
  value        = cap_state_attr_windows_val - cap_state_attr_windows_val_open
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SummerWindows.state
  attribute = cap_state_attr_windows
  value = cap_state_attr_windows_val_open
}



