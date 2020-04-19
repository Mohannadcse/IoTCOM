module app_TogglePoweronSchedule

open IoTBottomUp as base

open cap_switch


one sig app_TogglePoweronSchedule extends IoTApp {
  
  outlets : set cap_switch,
} {
  rules = r
}







// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_TogglePoweronSchedule.outlets
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val
}



