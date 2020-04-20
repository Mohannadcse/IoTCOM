module app_sound_the_110db_siren

open IoTBottomUp as base

open cap_alarm
open cap_switch

lone sig app_sound_the_110db_siren extends IoTApp {
  trigObj : one cap_switch,
  alarm : one cap_alarm,
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
  capabilities = app_sound_the_110db_siren.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_sound_the_110db_siren.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_siren
}



