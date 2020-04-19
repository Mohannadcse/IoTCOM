module app_accensione_riscaldamento_bassa_temperatura

open IoTBottomUp as base

open cap_temperatureMeasurement
open cap_switch

lone sig app_accensione_riscaldamento_bassa_temperatura extends IoTApp {
  trigObj : one cap_temperatureMeasurement,
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
  capabilities = app_accensione_riscaldamento_bassa_temperatura.trigObj
  attribute    = cap_temperatureMeasurement_attr_temperature
  value        = cap_temperatureMeasurement_attr_temperature_val_high
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_accensione_riscaldamento_bassa_temperatura.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



