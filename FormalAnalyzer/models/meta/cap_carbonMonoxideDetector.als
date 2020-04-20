
// filename: cap_carbonMonoxideDetector.als
module cap_carbonMonoxideDetector
open IoTBottomUp
one sig cap_carbonMonoxideDetector extends Capability {}
{
    attributes = cap_carbonMonoxideDetector_attr
}
abstract sig cap_carbonMonoxideDetector_attr extends Attribute {}
one sig cap_carbonMonoxideDetector_attr_carbonMonoxide extends cap_carbonMonoxideDetector_attr {}
{
    values = cap_carbonMonoxideDetector_attr_carbonMonoxide_val
} 
abstract sig cap_carbonMonoxideDetector_attr_carbonMonoxide_val extends AttrValue {}
one sig cap_carbonMonoxideDetector_attr_carbonMonoxide_val_clear extends cap_carbonMonoxideDetector_attr_carbonMonoxide_val {}
one sig cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected extends cap_carbonMonoxideDetector_attr_carbonMonoxide_val {}
one sig cap_carbonMonoxideDetector_attr_carbonMonoxide_val_tested extends cap_carbonMonoxideDetector_attr_carbonMonoxide_val {}
