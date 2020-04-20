
// filename: cap_threeAxis.als
module cap_threeAxis
open IoTBottomUp
one sig cap_threeAxis extends Capability {} 
{
  attributes = cap_threeAxis_attr
}
abstract sig cap_threeAxis_attr extends Attribute {}
one sig cap_threeAxis_attr_value extends cap_threeAxis_attr {} 
{
  values = cap_threeAxis_attr_value_val
}
abstract sig cap_threeAxis_attr_value_val extends AttrValue {}
one sig cap_threeAxis_attr_unit extends cap_threeAxis_attr {}
{
  values = cap_threeAxis_attr_unit_val
}
abstract sig cap_threeAxis_attr_unit_val extends AttrValue {]
one sig cap_threeAxis_attr_unit_val_mG extends cap_threeAxis_attr_unit_val {}

