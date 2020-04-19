module app_if_it_opens_call_me

open IoTBottomUp as base

open cap_doorControl
open cap_switch

lone sig app_if_it_opens_call_me extends IoTApp {
  trigObj : one cap_doorControl,
  switch : one cap_switch,
} {
  rules = r
}


// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_if_it_opens_call_me.trigObj
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_open
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_it_opens_call_me.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



