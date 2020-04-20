
// filename: cap_powerMeter.als
module cap_powerMeter
open IoTBottomUp
one sig cap_powerMeter extends Capability {}
{
    attributes = cap_powerMeter_attr
}
abstract sig cap_powerMeter_attr extends Attribute {}
one sig cap_powerMeter_attr_power extends cap_powerMeter_attr {}
{
    values = cap_powerMeter_attr_power_val
} 
abstract sig cap_powerMeter_attr_power_val extends AttrValue {}
