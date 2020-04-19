module app_when_door_window_is_opened_flash_my_smartthings_bulbs_red

open IoTBottomUp as base

open cap_doorControl
open cap_alarm

lone sig app_when_door_window_is_opened_flash_my_smartthings_bulbs_red extends IoTApp {
  trigObj : one cap_doorControl,
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
  capabilities = app_when_door_window_is_opened_flash_my_smartthings_bulbs_red.trigObj
  attribute    = cap_doorControl_attr_door
  value        = cap_doorControl_attr_door_val_open
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_when_door_window_is_opened_flash_my_smartthings_bulbs_red.alarm
  attribute    = cap_alarm_attr_alarm
  value        = cap_alarm_attr_alarm_val_siren
}



