
// filename: cap_fanSpeed.als
module cap_fanSpeed
open IoTBottomUp
one sig cap_fanSpeed extends Capability {}
{
    attributes = cap_fanSpeed_attr
}
abstract sig cap_fanSpeed_attr extends Attribute {}
one sig cap_fanSpeed_attr_fanSpeed extends cap_fanSpeed_attr {}
{
    values = cap_fanSpeed_attr_fanSpeed_val
} 
abstract sig cap_fanSpeed_attr_fanSpeed_val extends AttrValue {}
