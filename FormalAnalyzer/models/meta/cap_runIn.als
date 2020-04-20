module cap_runIn

open IoTBottomUp

abstract sig cap_runIn extends Capability {}
abstract sig cap_runIn_attr extends Attribute {}
one sig cap_runIn_attr_runIn extends cap_runIn_attr {} {
  values = cap_runIn_attr_val
}
abstract sig cap_runIn_attr_val extends AttrValue {}
one sig cap_runIn_attr_runIn_val_on, cap_runIn_attr_runIn_val_off extends cap_runIn_attr_val {}

