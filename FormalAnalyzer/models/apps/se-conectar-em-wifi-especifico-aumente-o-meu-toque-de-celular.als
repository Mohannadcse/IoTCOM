module app_se_conectar_em_wifi_especifico_aumente_o_meu_toque_de_celular

open IoTBottomUp as base

open cap_switch

lone sig app_se_conectar_em_wifi_especifico_aumente_o_meu_toque_de_celular extends IoTApp {
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
  capabilities = app_se_conectar_em_wifi_especifico_aumente_o_meu_toque_de_celular.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_se_conectar_em_wifi_especifico_aumente_o_meu_toque_de_celular.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



