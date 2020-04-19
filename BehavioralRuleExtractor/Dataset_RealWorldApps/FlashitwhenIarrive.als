module app_FlashitwhenIarrive

open IoTBottomUp as base

open cap_switch
open cap_presenceSensor


one sig app_FlashitwhenIarrive extends IoTApp {
  
  myPresence : set cap_presenceSensor,
  state : one cap_state,
  switches : some cap_switch,
} {
  rules = r
}

one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_lastActivated extends cap_state_attr {} {
  values = cap_state_attr_lastActivated_val
}

abstract sig cap_state_attr_lastActivated_val extends AttrValue {}





// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_FlashitwhenIarrive.myPresence
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_FlashitwhenIarrive.myPresence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_FlashitwhenIarrive.state
  attribute = cap_state_attr_lastActivated
  value = cap_state_attr_lastActivated_val
}



