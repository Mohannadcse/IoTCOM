
// filename: cap_smokeDetector.als
module cap_smokeDetector
open IoTBottomUp
one sig cap_smokeDetector extends Capability {}
{
    attributes = cap_smokeDetector_attr
}
abstract sig cap_smokeDetector_attr extends Attribute {}
one sig cap_smokeDetector_attr_smoke extends cap_smokeDetector_attr {}
{
    values = cap_smokeDetector_attr_smoke_val
} 
abstract sig cap_smokeDetector_attr_smoke_val extends AttrValue {}
one sig cap_smokeDetector_attr_smoke_val_clear extends cap_smokeDetector_attr_smoke_val {}
one sig cap_smokeDetector_attr_smoke_val_detected extends cap_smokeDetector_attr_smoke_val {}
one sig cap_smokeDetector_attr_smoke_val_tested extends cap_smokeDetector_attr_smoke_val {}
