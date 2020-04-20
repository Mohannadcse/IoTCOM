
// filename: cap_filterStatus.als
module cap_filterStatus
open IoTBottomUp
one sig cap_filterStatus extends Capability {}
{
    attributes = cap_filterStatus_attr
}
abstract sig cap_filterStatus_attr extends Attribute {}
one sig cap_filterStatus_attr_filterStatus extends cap_filterStatus_attr {}
{
    values = cap_filterStatus_attr_filterStatus_val
} 
abstract sig cap_filterStatus_attr_filterStatus_val extends AttrValue {}
one sig cap_filterStatus_attr_filterStatus_val_normal extends cap_filterStatus_attr_filterStatus_val {}
one sig cap_filterStatus_attr_filterStatus_val_replace extends cap_filterStatus_attr_filterStatus_val {}
