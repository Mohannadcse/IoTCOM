module cap_userInput

open IoTBottomUp

one sig cap_userInput extends Capability {} {
  attributes = cap_userInput_attr
}

abstract sig cap_userInput_attr extends Attribute {}
one sig cap_userInput_attr_value extends cap_userInput_attr {} {
  values = cap_userInput_attr_value_val
}

abstract sig cap_userInput_attr_value_val extends AttrValue {}

abstract sig cap_userInput_attr_value_boolval extends cap_userInput_attr_value_val {}
one sig cap_userInput_attr_value_boolval_true, cap_userInput_attr_value_boolval_false extends cap_userInput_attr_value_boolval {}
