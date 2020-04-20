module cap_app
open IoTBottomUp
one sig cap_app extends Capability {}
{
    attributes = cap_app_attr
}
abstract sig cap_app_attr extends Attribute {}
one sig cap_app_attr_app extends cap_app_attr {}
{
    values = cap_app_attr_app_val
} 
abstract sig cap_app_attr_app_val extends AttrValue {}

one sig cap_app_attr_app_val_appTouch extends cap_app_attr_app_val {}

one sig cap_app_attr_app_val_appTouch_Not extends cap_app_attr_app_val {}
