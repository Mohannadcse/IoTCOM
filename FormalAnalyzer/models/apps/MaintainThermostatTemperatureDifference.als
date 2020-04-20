module app_MaintainThermostatTemperatureDifference

open IoTBottomUp as base

open cap_thermostat


one sig app_MaintainThermostatTemperatureDifference extends IoTApp {
  
  targetThermostat : set cap_thermostat,
  
  sourceThermostat : lone cap_thermostat,
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
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat //cap_thermostat_attr_coolingSetpoint
  value = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}
one sig r0_trig1 extends r0_trig {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat //cap_thermostat_attr_heatingSetpoint
  value = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat //cap_thermostat_attr_coolingSetpoint
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_MaintainThermostatTemperatureDifference.targetThermostat
  attribute = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}
one sig r1_trig1 extends r1_trig {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint - cap_thermostat_attr_thermostat_val_setHeatingSetpoint
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_MaintainThermostatTemperatureDifference.sourceThermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_thermostat_attr_thermostat_val_setCoolingSetpoint
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_MaintainThermostatTemperatureDifference.targetThermostat
  attribute = cap_thermostat_attr_thermostat
  value = cap_thermostat_attr_thermostat_val
}



