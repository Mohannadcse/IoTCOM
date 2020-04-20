
// filename: cap_momentary.als
module cap_momentary
open IoTBottomUp
one sig cap_momentary extends Capability {}
{ 
  attributes = cap_momentary_attr
}
abstract sig cap_momentary_attr extends Attribute {}
