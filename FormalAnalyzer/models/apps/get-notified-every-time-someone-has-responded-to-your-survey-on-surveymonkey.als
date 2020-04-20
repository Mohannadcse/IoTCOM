module app_get_notified_every_time_someone_has_responded_to_your_survey_on_surveymonkey

open IoTBottomUp as base

open cap_switch

lone sig app_get_notified_every_time_someone_has_responded_to_your_survey_on_surveymonkey extends IoTApp {
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
  capabilities = app_get_notified_every_time_someone_has_responded_to_your_survey_on_surveymonkey.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_get_notified_every_time_someone_has_responded_to_your_survey_on_surveymonkey.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



