module app_NotifyMeasILeaveThatILeftItOpen

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_presenceSensor
open cap_contactSensor


one sig app_NotifyMeasILeaveThatILeftItOpen extends IoTApp {
  
  departer : one cap_presenceSensor,
  
  contact : one cap_contactSensor,
  
  state : one cap_state,
} {
  rules = r
  //capabilities = departer + contact + state
}


one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}





abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_NotifyMeasILeaveThatILeftItOpen.departer
  attribute    = cap_presenceSensor_attr_presence
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_NotifyMeasILeaveThatILeftItOpen.departer
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_NotifyMeasILeaveThatILeftItOpen.state
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}



