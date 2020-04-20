
// filename: cap_tone.als
module cap_tone
open IoTBottomUp
one sig cap_tone extends Capability {}
{
    attributes = cap_tone_attr
}
abstract sig cap_tone_attr extends Attribute {}
