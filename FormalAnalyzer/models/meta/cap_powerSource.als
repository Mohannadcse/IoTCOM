
// filename: cap_powerSource.als
module cap_powerSource
open IoTBottomUp
one sig cap_powerSource extends Capability {}
{
    attributes = cap_powerSource_attr
}
abstract sig cap_powerSource_attr extends Attribute {}
one sig cap_powerSource_attr_powerSource extends cap_powerSource_attr {}
{
    values = cap_powerSource_attr_powerSource_val
} 
abstract sig cap_powerSource_attr_powerSource_val extends AttrValue {}
one sig cap_powerSource_attr_powerSource_val_battery extends cap_powerSource_attr_powerSource_val {}
one sig cap_powerSource_attr_powerSource_val_dc extends cap_powerSource_attr_powerSource_val {}
one sig cap_powerSource_attr_powerSource_val_mains extends cap_powerSource_attr_powerSource_val {}
one sig cap_powerSource_attr_powerSource_val_unknown extends cap_powerSource_attr_powerSource_val {}
