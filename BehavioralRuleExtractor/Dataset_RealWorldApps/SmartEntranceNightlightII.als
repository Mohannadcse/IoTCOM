module app_SmartEntranceNightlightII

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_contactSensor
open cap_switch


one sig app_SmartEntranceNightlightII extends IoTApp {
  
  contact1 : one cap_contactSensor,
  
  switches : some cap_switch,
  now : one cap_now,
  state : one cap_state,
} {
  rules = r
  //capabilities = contact1 + switches + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}



//one sig cap_now_attr_now_val_gte_noValue extends cap_now_attr_now_val {}
//one sig cap_now_attr_now_val_lte_noValue extends cap_now_attr_now_val {}

one sig range_0,range_1 extends cap_now_attr_now_val {}


abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_SmartEntranceNightlightII.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_SmartEntranceNightlightII.switches
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
  capabilities = app_SmartEntranceNightlightII.contact1
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_SmartEntranceNightlightII.now
  attribute    = cap_now_attr_now
  value        = range_0 //cap_now_attr_now_val_lte_noValue
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_SmartEntranceNightlightII.now
  attribute    = cap_now_attr_now
  value        = range_1 //cap_now_attr_now_val_gte_noValue
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_SmartEntranceNightlightII.switches
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r1_comm1 extends r1_comm {} {
  capability   = app_SmartEntranceNightlightII.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



