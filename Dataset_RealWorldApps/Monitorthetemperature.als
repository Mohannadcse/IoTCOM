module app_Monitorthetemperature

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_temperatureMeasurement


one sig app_Monitorthetemperature extends IoTApp {
  
  temperatureSensor1 : one cap_temperatureMeasurement,
} {
  rules = r
  //capabilities = temperatureSensor1
}






abstract sig r extends Rule {}



