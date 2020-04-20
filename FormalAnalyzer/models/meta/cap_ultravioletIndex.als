
// filename: cap_ultravioletIndex.als
module cap_ultravioletIndex
open IoTBottomUp
one sig cap_ultravioletIndex extends Capability {}
{
    attributes = cap_ultravioletIndex_attr
}
abstract sig cap_ultravioletIndex_attr extends Attribute {}
one sig cap_ultravioletIndex_attr_ultravioletIndex extends cap_ultravioletIndex_attr {}
{
    values = cap_ultravioletIndex_attr_ultravioletIndex_val
} 
abstract sig cap_ultravioletIndex_attr_ultravioletIndex_val extends AttrValue {}
one sig cap_ultravioletIndex_attr_ultravioletIndex_val0 extends cap_ultravioletIndex_attr_ultravioletIndex_val {}
