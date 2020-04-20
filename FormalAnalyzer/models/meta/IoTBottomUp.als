module IoTBottomUp

abstract sig Capability { 
  attributes : set Attribute,
}

abstract sig Attribute { 
  values : set AttrValue 
}

abstract sig AttrValue {}

abstract sig IoTApp {
  rules : set Rule
}

abstract sig Rule {
  triggers   : set Trigger,
  conditions : set Condition,
  commands   : set Command,
  connected  : set Rule,
  siblings   : set Rule,
  indirect   : set Rule,
  scheduled  : set Rule,
}

abstract sig Trigger {
  capabilities : one Capability,
  attribute : one Attribute,
  value : lone AttrValue
} {
  attribute in capabilities.attributes
  no value or value in attribute.values
}

abstract sig Condition {
  capabilities : one Capability,
  attribute : one Attribute,
  value : some AttrValue
} {
  attribute in capabilities.attributes
  value in attribute.values
}

abstract sig Command {
  capability : one Capability,
  attribute : one Attribute,
  value : one AttrValue
} {
  attribute in capability.attributes
  value in attribute.values
}
