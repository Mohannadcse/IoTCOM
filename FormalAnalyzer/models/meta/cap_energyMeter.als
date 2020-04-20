
// filename: cap_energyMeter.als
module cap_energyMeter
open IoTBottomUp
one sig cap_energyMeter extends Capability {}
{
    attributes = cap_energyMeter_attr
}
abstract sig cap_energyMeter_attr extends Attribute {}
one sig cap_energyMeter_attr_energy extends cap_energyMeter_attr {}
{
    values = cap_energyMeter_attr_energy_val
} 
abstract sig cap_energyMeter_attr_energy_val extends AttrValue {}
