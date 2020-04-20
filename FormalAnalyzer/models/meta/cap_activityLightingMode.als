
// filename: cap_activityLightingMode.als
module cap_activityLightingMode
open IoTBottomUp
one sig cap_activityLightingMode extends Capability {}
{
    attributes = cap_activityLightingMode_attr
}
abstract sig cap_activityLightingMode_attr extends Attribute {}
one sig cap_activityLightingMode_attr_lightingMode extends cap_activityLightingMode_attr {}
{
    values = cap_activityLightingMode_attr_lightingMode_val
} 
abstract sig cap_activityLightingMode_attr_lightingMode_val extends AttrValue {}
one sig cap_activityLightingMode_attr_lightingMode_val_reading extends cap_activityLightingMode_attr_lightingMode_val {}
one sig cap_activityLightingMode_attr_lightingMode_val_writing extends cap_activityLightingMode_attr_lightingMode_val {}
one sig cap_activityLightingMode_attr_lightingMode_val_computer extends cap_activityLightingMode_attr_lightingMode_val {}
one sig cap_activityLightingMode_attr_lightingMode_val_night extends cap_activityLightingMode_attr_lightingMode_val {}
