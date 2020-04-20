
// filename: cap_alarm.als
module cap_alarm
open IoTBottomUp
one sig cap_alarm extends Capability {}
{
    attributes = cap_alarm_attr
}
abstract sig cap_alarm_attr extends Attribute {}
one sig cap_alarm_attr_alarm extends cap_alarm_attr {}
{
    values = cap_alarm_attr_alarm_val
} 
abstract sig cap_alarm_attr_alarm_val extends AttrValue {}
one sig cap_alarm_attr_alarm_val_both extends cap_alarm_attr_alarm_val {}
one sig cap_alarm_attr_alarm_val_off extends cap_alarm_attr_alarm_val {}
one sig cap_alarm_attr_alarm_val_siren extends cap_alarm_attr_alarm_val {}
one sig cap_alarm_attr_alarm_val_strobe extends cap_alarm_attr_alarm_val {}
