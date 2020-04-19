module app_SwitchOffTimer

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch


lone sig app_SwitchOffTimer extends IoTApp {
  
  timeoutSwitch : one cap_switch,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = timeoutSwitch + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



one sig cap_state_attr_timeoutSwitchOnTime extends cap_state_attr {} {
  values = cap_state_attr_timeoutSwitchOnTime_val
}

abstract sig cap_state_attr_timeoutSwitchOnTime_val extends AttrValue {}
one sig cap_state_attr_timeoutSwitchOnTime_val_0 extends cap_state_attr_timeoutSwitchOnTime_val {}



// application rules base class

abstract sig r extends Rule {}


one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SwitchOffTimer.state
  attribute    = cap_state_attr_timeoutSwitchOnTime
  value        = cap_state_attr_timeoutSwitchOnTime_val - cap_state_attr_timeoutSwitchOnTime_val_0
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_SwitchOffTimer.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SwitchOffTimer.timeoutSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r0_comm1 extends r0_comm {} {
  capability   = app_SwitchOffTimer.state
  attribute    = cap_state_attr_timeoutSwitchOnTime
  value        = cap_state_attr_timeoutSwitchOnTime_val_0
}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions //= r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_SwitchOffTimer.timeoutSwitch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_cond extends Condition {}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SwitchOffTimer.state
  attribute    = cap_state_attr_timeoutSwitchOnTime
  value        = cap_state_attr_timeoutSwitchOnTime_val
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SwitchOffTimer.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



