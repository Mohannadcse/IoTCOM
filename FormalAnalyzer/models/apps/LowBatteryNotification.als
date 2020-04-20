module app_LowBatteryNotification

open IoTBottomUp as base
open cap_runIn
open cap_now

open cap_battery


one sig app_LowBatteryNotification extends IoTApp {
  
  devices : some cap_battery,
} {
  rules = r
  //capabilities = devices
}






abstract sig r extends Rule {}



