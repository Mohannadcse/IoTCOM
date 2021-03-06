module app_congress_schedules_vote_on_bill_then_android_notify

open IoTBottomUp as base

open cap_switch

lone sig app_congress_schedules_vote_on_bill_then_android_notify extends IoTApp {
  trigObj : one cap_switch,
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
  capabilities = app_congress_schedules_vote_on_bill_then_android_notify.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_congress_schedules_vote_on_bill_then_android_notify.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



