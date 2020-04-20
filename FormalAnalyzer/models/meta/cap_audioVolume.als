
// filename: cap_audioVolume.als
module cap_audioVolume
open IoTBottomUp
one sig cap_audioVolume extends Capability {}
{
    attributes = cap_audioVolume_attr
}
abstract sig cap_audioVolume_attr extends Attribute {}
one sig cap_audioVolume_attr_volume extends cap_audioVolume_attr {}
{
    values = cap_audioVolume_attr_volume_val
} 
abstract sig cap_audioVolume_attr_volume_val extends AttrValue {}
