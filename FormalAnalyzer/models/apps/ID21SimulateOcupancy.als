module app_ID21SimulateOcupancy

open IoTBottomUp as base

open cap_switch
open cap_runIn

open cap_app

one sig app_ID21SimulateOcupancy extends IoTApp {
  
  runIn : one cap_state,
  
  app : one cap_app,
  
  state : one cap_state,
  
  switches : some cap_switch,
} {
  rules = r
}



one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}

one sig cap_state_attr_turnOffTime extends cap_state_attr {} {
  values = cap_state_attr_turnOffTime_val
}
one sig cap_state_attr_turnOffTime_val extends AttrValue {}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  no conditions
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID21SimulateOcupancy.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID21SimulateOcupancy.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_on
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID21SimulateOcupancy.app
  attribute    = cap_app_attr_app
  value        = cap_app_attr_app_val_appTouch
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID21SimulateOcupancy.state
  attribute = cap_state_attr_turnOffTime
  value = cap_state_attr_turnOffTime_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_ID21SimulateOcupancy.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID21SimulateOcupancy.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID21SimulateOcupancy.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}



