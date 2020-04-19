module app_HumidityResetSchedule

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_thermostat
open cap_userInput

one sig app_HumidityResetSchedule extends IoTApp {
  
  thermostat : one cap_thermostat,
  humiditySetpoint : one cap_userInput
} {
  rules = r
  //capabilities = thermostat + humiditySetpoint
}


one sig cap_userInput_attr_humiditySetpoint extends cap_userInput_attr {}
{
    values = cap_userInput_attr_humiditySetpoint_val
} 


abstract sig cap_userInput_attr_humiditySetpoint_val extends cap_userInput_attr_value_val {}



abstract sig r extends Rule {}

one sig r0 extends r {}{
  no triggers
  conditions = r0_cond
  commands   = r0_comm
}




abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_HumidityResetSchedule.thermostat
  attribute    = cap_thermostat_attr_thermostat
  value        = cap_userInput_attr_humiditySetpoint_val
}



