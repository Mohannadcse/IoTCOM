
// filename: cap_signalStrength.als
module cap_signalStrength
open IoTBottomUp
one sig cap_signalStrength extends Capability {}
{
    attributes = cap_signalStrength_attr
}
abstract sig cap_signalStrength_attr extends Attribute {}
one sig cap_signalStrength_attr_lqi extends cap_signalStrength_attr {}
{
    values = cap_signalStrength_attr_lqi_val
} 
abstract sig cap_signalStrength_attr_lqi_val extends AttrValue {}
one sig cap_signalStrength_attr_rssi extends cap_signalStrength_attr {}
{
    values = cap_signalStrength_attr_rssi_val
} 
abstract sig cap_signalStrength_attr_rssi_val extends AttrValue {}
