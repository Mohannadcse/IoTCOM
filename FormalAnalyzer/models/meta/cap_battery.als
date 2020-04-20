
// filename: cap_battery.als
module cap_battery
open IoTBottomUp
one sig cap_battery extends Capability {}
{
    attributes = cap_battery_attr
}
abstract sig cap_battery_attr extends Attribute {}
one sig cap_battery_attr_battery extends cap_battery_attr {}
{
    values = cap_battery_attr_battery_val
} 
abstract sig cap_battery_attr_battery_val extends AttrValue {}
