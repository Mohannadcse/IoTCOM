module app_FloodWatch

open IoTBottomUp as base

open cap_waterSensor


one sig app_FloodWatch extends IoTApp {
  
  waterSensors : set cap_waterSensor,
} {
  rules = r
}







// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_FloodWatch.waterSensors
  attribute = cap_waterSensor_attr_water
  value = cap_waterSensor_attr_water_val
}



