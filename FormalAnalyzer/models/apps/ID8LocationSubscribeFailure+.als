module app_ID8LocationSubscribeFailure

open IoTBottomUp as base

open cap_location
open cap_presenceSensor


one sig app_ID8LocationSubscribeFailure extends IoTApp {
  
  people : some cap_presenceSensor,
  
  location : one cap_location,
} {
  rules = r
}







// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID8LocationSubscribeFailure.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID8LocationSubscribeFailure.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID8LocationSubscribeFailure.location
  attribute = cap_location_attr_mode
  value = cap_location_attr_mode_val_Away
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID8LocationSubscribeFailure.people
  attribute    = cap_presenceSensor_attr_presence
  no value
  //value        = cap_presenceSensor_attr_presence_val
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID8LocationSubscribeFailure.people
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val - cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID8LocationSubscribeFailure.location
  attribute = cap_location_attr_mode
  value = cap_location_attr_mode_val_Home
}



