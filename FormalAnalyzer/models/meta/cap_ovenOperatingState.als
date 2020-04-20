
// filename: cap_ovenOperatingState.als
module cap_ovenOperatingState
open IoTBottomUp
one sig cap_ovenOperatingState extends Capability {}
{
    attributes = cap_ovenOperatingState_attr
}
abstract sig cap_ovenOperatingState_attr extends Attribute {}
one sig cap_ovenOperatingState_attr_machineState extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_machineState_val
} 
abstract sig cap_ovenOperatingState_attr_machineState_val extends AttrValue {}
one sig cap_ovenOperatingState_attr_machineState_val_ready extends cap_ovenOperatingState_attr_machineState_val {}
one sig cap_ovenOperatingState_attr_machineState_val_running extends cap_ovenOperatingState_attr_machineState_val {}
one sig cap_ovenOperatingState_attr_machineState_val_paused extends cap_ovenOperatingState_attr_machineState_val {}
one sig cap_ovenOperatingState_attr_supportedMachineStates extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_supportedMachineStates_val
} 
abstract sig cap_ovenOperatingState_attr_supportedMachineStates_val extends AttrValue {}
one sig cap_ovenOperatingState_attr_ovenJobState extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_ovenJobState_val
} 
abstract sig cap_ovenOperatingState_attr_ovenJobState_val extends AttrValue {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_cleaning extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_cooking extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_cooling extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_draining extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_preheat extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_ready extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_ovenJobState_val_rinsing extends cap_ovenOperatingState_attr_ovenJobState_val {}
one sig cap_ovenOperatingState_attr_completionTime extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_completionTime_val
} 
abstract sig cap_ovenOperatingState_attr_completionTime_val extends AttrValue {}
one sig cap_ovenOperatingState_attr_operationTime extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_operationTime_val
} 
abstract sig cap_ovenOperatingState_attr_operationTime_val extends AttrValue {}
one sig cap_ovenOperatingState_attr_progress extends cap_ovenOperatingState_attr {}
{
    values = cap_ovenOperatingState_attr_progress_val
} 
abstract sig cap_ovenOperatingState_attr_progress_val extends AttrValue {}
