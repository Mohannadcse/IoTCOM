module app_ArrivalbasedNightLightwithSmartAutooff

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_illuminanceMeasurement
open cap_switch


one sig app_ArrivalbasedNightLightwithSmartAutooff extends IoTApp {
  
  people : some cap_presenceSensor,
  
  luminance : one cap_illuminanceMeasurement,
  
  selectedSwitch : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = people + luminance + selectedSwitch + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_timeLastTriggered extends cap_state_attr {} {
  values = cap_state_attr_timeLastTriggered_val
}

abstract sig cap_state_attr_timeLastTriggered_val extends AttrValue {}
one sig cap_state_attr_timeLastTriggered_val_0 extends cap_state_attr_timeLastTriggered_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ArrivalbasedNightLightwithSmartAutooff.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ArrivalbasedNightLightwithSmartAutooff.selectedSwitch
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
  capabilities = app_ArrivalbasedNightLightwithSmartAutooff.people
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ArrivalbasedNightLightwithSmartAutooff.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ArrivalbasedNightLightwithSmartAutooff.selectedSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ArrivalbasedNightLightwithSmartAutooff.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}
/*
one sig r1_comm2 extends r1_comm {} {
  capability   = app_ArrivalbasedNightLightwithSmartAutooff.state
  attribute    = cap_timeLastTriggered_attr_timeLastTriggered
  value        = cap_timeLastTriggered_attr_timeLastTriggered_val_not_null
}
*/



