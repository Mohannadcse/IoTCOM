
// filename: cap_tvChannel.als
module cap_tvChannel
open IoTBottomUp
one sig cap_tvChannel extends Capability {}
{
    attributes = cap_tvChannel_attr
}
abstract sig cap_tvChannel_attr extends Attribute {}
one sig cap_tvChannel_attr_tvChannel extends cap_tvChannel_attr {}
{
    values = cap_tvChannel_attr_tvChannel_val
} 
abstract sig cap_tvChannel_attr_tvChannel_val extends AttrValue {}
