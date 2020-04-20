// filename: cap_location.als
module cap_location
open IoTBottomUp
one sig cap_location extends Capability{}
{
    attributes = cap_location_attr
}
abstract sig cap_location_attr extends Attribute {}
one sig cap_location_attr_mode extends cap_location_attr {}
{
    values = cap_location_attr_mode_val
}
abstract sig cap_location_attr_mode_val extends AttrValue {}
one sig cap_location_attr_mode_val_Home extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_Away extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_Night extends cap_location_attr_mode_val {}{}
one sig cap_location_attr_mode_val_Vacation extends cap_location_attr_mode_val {}{}

one sig cap_location_attr_position extends cap_location_attr {}
{
    values = cap_location_attr_position_val
}
abstract sig cap_location_attr_position_val extends AttrValue {}

one sig cap_location_attr_sunSet extends cap_location_attr {}
{
    values = cap_location_attr_sunSet_val
}
abstract sig cap_location_attr_sunSet_val extends AttrValue {}

one sig cap_location_attr_sunSet_val_ON extends cap_location_attr_sunSet_val {}
one sig cap_location_attr_sunSet_val_OFF extends cap_location_attr_sunSet_val {}

one sig cap_location_attr_sunRise extends cap_location_attr {}
{
    values = cap_location_attr_sunRise_val
}
abstract sig cap_location_attr_sunRise_val extends AttrValue {}
one sig cap_location_attr_sunRise_val0 extends cap_location_attr_sunRise_val {}

abstract sig cap_location_attr_sunRise_val_ON extends cap_location_attr_sunRise_val {}
abstract sig cap_location_attr_sunRise_val_OFF extends cap_location_attr_sunRise_val {}

one sig cap_location_attr_sunsetTime extends cap_location_attr {}
{
    values = cap_location_attr_sunsetTime_val
}
abstract sig cap_location_attr_sunsetTime_val extends AttrValue {}

one sig cap_location_attr_sunriseTime extends cap_location_attr {}
{
    values = cap_location_attr_sunriseTime_val
}
abstract sig cap_location_attr_sunriseTime_val extends AttrValue {}
one sig cap_location_attr_sunriseTime_val0 extends cap_location_attr_sunriseTime_val {}


