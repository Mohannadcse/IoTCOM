module app_ModeButton

open IoTBottomUp as base

open cap_location
open cap_switch
open cap_button


one sig app_ModeButton extends IoTApp {
  
  heldSwitchOn : some cap_switch,
  
  switchOff : some cap_switch,
  
  heldSwitchOff : some cap_switch,
  
  state : one cap_state,
  
  button : one cap_button,
  
  location : one cap_location,
  
  newMode : one cap_location_attr_mode_val,
  
  switchOn : some cap_switch,
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
one sig cap_state_attr_mode_val_heldMode extends cap_state_attr_mode_val {}
one sig cap_state_attr_mode_val_pushMode extends cap_state_attr_mode_val {}

one sig cap_location_attr_mode_val_newMode extends cap_location_attr_mode_val {}{}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_pushed
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ModeButton.switchOn
  attribute    = cap_switch_attr_switch
  no value        //= cap_switch_attr_switch_on
}
/*
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_pushed
  value        = cap_button_attr_pushed_val
}
*/

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ModeButton.switchOn
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_held
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ModeButton.heldSwitchOn
  attribute    = cap_switch_attr_switch
  no value        //= cap_switch_attr_any_val
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ModeButton.heldSwitchOn
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r2 extends r {}{
  triggers   = r2_trig
  conditions = r2_cond
  commands   = r2_comm
}

abstract sig r2_trig extends Trigger {}

one sig r2_trig0 extends r2_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_held
}


abstract sig r2_cond extends Condition {}

one sig r2_cond1 extends r2_cond {} {
  capabilities = app_ModeButton.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ModeButton.newMode
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ModeButton.location
  attribute = cap_location_attr_mode
  value        = app_ModeButton.newMode
}

one sig r3 extends r {}{
  triggers   = r3_trig
  conditions = r3_cond
  commands   = r3_comm
}

abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_pushed
}


abstract sig r3_cond extends Condition {}

one sig r3_cond2 extends r3_cond {} {
  capabilities = app_ModeButton.switchOff
  attribute    = cap_switch_attr_switch
  no value        //= cap_switch_attr_any_val
}

abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_ModeButton.switchOff
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r4 extends r {}{
  triggers   = r4_trig
  conditions = r4_cond
  commands   = r4_comm
}

abstract sig r4_trig extends Trigger {}

one sig r4_trig0 extends r4_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_held
}


abstract sig r4_cond extends Condition {}

one sig r4_cond2 extends r4_cond {} {
  capabilities = app_ModeButton.heldSwitchOff
  attribute    = cap_switch_attr_switch
  no value        //= cap_switch_attr_any_val
}

abstract sig r4_comm extends Command {}

one sig r4_comm0 extends r4_comm {} {
  capability   = app_ModeButton.heldSwitchOff
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}

one sig r5 extends r {}{
  triggers   = r5_trig
  conditions = r5_cond
  commands   = r5_comm
}

abstract sig r5_trig extends Trigger {}

one sig r5_trig0 extends r5_trig {} {
  capabilities = app_ModeButton.button
  attribute    = cap_button_attr_button
  value        = cap_button_attr_button_val_pushed
}


abstract sig r5_cond extends Condition {}

one sig r5_cond1 extends r5_cond {} {
  capabilities = app_ModeButton.location
  attribute    = cap_location_attr_mode
  value        = cap_location_attr_mode_val - app_ModeButton.newMode
}

abstract sig r5_comm extends Command {}

one sig r5_comm0 extends r5_comm {} {
  capability   = app_ModeButton.location
  attribute = cap_location_attr_mode
  value        = app_ModeButton.newMode //cap_location_attr_mode_val_newMode
}



