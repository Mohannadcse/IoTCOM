module app_SwitchChangesMode

open IoTBottomUp as base

open cap_location
open cap_switch


one sig app_SwitchChangesMode extends IoTApp {
  
  controlSwitch : lone cap_switch,
  
  state : one cap_state,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
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
one sig cap_state_attr_mode_val_onMode extends cap_state_attr_mode_val {}
one sig cap_state_attr_mode_val_offMode extends cap_state_attr_mode_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_SwitchChangesMode.controlSwitch
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SwitchChangesMode.controlSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_SwitchChangesMode.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_SwitchChangesMode.newMode
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SwitchChangesMode.location
  attribute = cap_location_attr_mode
  value        = app_SwitchChangesMode.newMode
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SwitchChangesMode.controlSwitch
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SwitchChangesMode.controlSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SwitchChangesMode.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_SwitchChangesMode.newMode
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SwitchChangesMode.location
  attribute = cap_location_attr_mode
  value        = app_SwitchChangesMode.newMode
}



