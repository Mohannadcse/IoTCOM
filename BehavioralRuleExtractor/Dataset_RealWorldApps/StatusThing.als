module app_StatusThing

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_switch
open cap_temperatureMeasurement
open cap_thermostat


one sig app_StatusThing extends IoTApp {
  
  switches : set cap_switch,
  
  temperatures : some cap_temperatureMeasurement,
  
  thermostats : some cap_thermostat,
} {
  rules = r
  //capabilities = switches + temperatures + thermostats
}






abstract sig r extends Rule {}



