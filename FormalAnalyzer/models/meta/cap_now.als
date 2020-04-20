module cap_now

open IoTBottomUp

one sig cap_now extends Capability {} {
  attributes = cap_now_attr
}
abstract sig cap_now_attr extends Attribute {}
one sig cap_now_attr_now extends cap_now_attr {} {
  values = cap_now_attr_now_val
}
abstract sig cap_now_attr_now_val extends AttrValue {}
one sig cap_now_attr_now_val0 extends cap_now_attr_now_val {}
