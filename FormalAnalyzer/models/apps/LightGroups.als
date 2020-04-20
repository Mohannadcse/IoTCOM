module app_LightGroups

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_switchLevel
open cap_colorControl


one sig app_LightGroups extends IoTApp {
  
  switches : some cap_switch,
  
  dimmers : some cap_switchLevel,
  
  colorControls : some cap_colorControl,
} {
  rules = r
  //capabilities = switches + dimmers + colorControls
}






abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_LightGroups.dimmers
  attribute    = cap_switchLevel_attr_level
  value        = cap_switchLevel_attr_level_val
}

one sig r1 extends r {}{
  no triggers   //= r1_trig
  conditions = r1_cond
  commands   = r1_comm
}
/*
abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capability   = app_LightGroups.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
*/


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_LightGroups.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}


abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_LightGroups.colorControls
  attribute    = cap_colorControl_attr_hue
  value        = cap_colorControl_attr_hue_val
}
one sig r2_comm1 extends r2_comm {} {
  capability   = app_LightGroups.colorControls
  attribute    = cap_colorControl_attr_color
  value        = cap_colorControl_attr_color_val
}
one sig r2_comm2 extends r2_comm {} {
  capability   = app_LightGroups.colorControls
  attribute    = cap_colorControl_attr_saturation
  value        = cap_colorControl_attr_saturation_val
}

one sig r3 extends r {}{
  no triggers //= r3_trig
  conditions = r3_cond
  commands   = r3_comm
}
/*
abstract sig r3_trig extends Trigger {}

one sig r3_trig0 extends r3_trig {} {
  capability   = app_LightGroups.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
*/


abstract sig r3_cond extends Condition {}


abstract sig r3_comm extends Command {}

one sig r3_comm0 extends r3_comm {} {
  capability   = app_LightGroups.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



