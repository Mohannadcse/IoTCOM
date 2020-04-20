module app_si_connecter_au_reseau_wifi_du_domicile_regle_le_volume_de_ma_sonnerie

open IoTBottomUp as base

open cap_switch

lone sig app_si_connecter_au_reseau_wifi_du_domicile_regle_le_volume_de_ma_sonnerie extends IoTApp {
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
  capabilities = app_si_connecter_au_reseau_wifi_du_domicile_regle_le_volume_de_ma_sonnerie.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_si_connecter_au_reseau_wifi_du_domicile_regle_le_volume_de_ma_sonnerie.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



