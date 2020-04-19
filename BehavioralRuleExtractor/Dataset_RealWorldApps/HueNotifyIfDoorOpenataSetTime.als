module app_HueNotifyIfDoorOpenataSetTime

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_colorControl


one sig app_HueNotifyIfDoorOpenataSetTime extends IoTApp {
  
  garageDoorStatus : one cap_contactSensor,
  
  hues : some cap_colorControl,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = garageDoorStatus + hues + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}
/*
one sig r0_comm0 extends r0_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.state
  attribute    = cap_previous_attr_previous
  value        = cap_previous_attr_previous_val_not_null
}
*/
one sig r0_comm3 extends r0_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_hue
  value        = cap_colorControl_attr_hue_val
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_saturation
  value        = cap_colorControl_attr_saturation_val
}
one sig r0_comm2 extends r0_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_color
  value        = cap_colorControl_attr_color_val
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_HueNotifyIfDoorOpenataSetTime.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_hue
  value        = cap_colorControl_attr_hue_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_saturation
  value        = cap_colorControl_attr_saturation_val
}
one sig r1_comm2 extends r1_comm {} {
  capability   = app_HueNotifyIfDoorOpenataSetTime.hues
  attribute    = cap_colorControl_attr_color
  value        = cap_colorControl_attr_color_val
}


