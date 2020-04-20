module IoTChannel

open IoTBottomUp as base

open cap_carbonDioxideMeasurement
open cap_carbonMonoxideDetector
open cap_carbonMonoxideMeasurement
open cap_contactSensor
open cap_illuminanceMeasurement
open cap_location
open cap_motionSensor
open cap_presenceSensor
open cap_relativeHumidityMeasurement
open cap_smokeDetector
open cap_switch
open cap_switchLevel
open cap_temperatureMeasurement
open cap_thermostat
open cap_valve
open cap_waterSensor
open cap_ovenMode

abstract sig Channel {
  sensors   : set Capability,
  actuators : set Capability
}
one sig ch_temperature extends Channel {} {
  sensors   = cap_temperatureMeasurement 
  actuators = cap_switch + cap_thermostat + cap_ovenMode
}
one sig ch_luminance extends Channel {} {
  sensors   = cap_illuminanceMeasurement
  actuators = cap_switch + cap_switchLevel
}
one sig ch_motion extends Channel {} {
  sensors   = cap_motionSensor + cap_contactSensor
  actuators = cap_switch
}
one sig ch_humidity extends Channel {} {
  sensors   = cap_relativeHumidityMeasurement
  actuators = cap_switch
}
one sig ch_leakage extends Channel {} {
  sensors   = cap_waterSensor
  actuators = cap_valve
}
one sig ch_location extends Channel {} {
  sensors   = cap_presenceSensor
  actuators = cap_location
}
one sig ch_smoke extends Channel {} {
  sensors   = cap_smokeDetector + cap_carbonDioxideMeasurement + cap_carbonMonoxideMeasurement + cap_carbonMonoxideDetector
  actuators = cap_switch + cap_ovenMode
}
