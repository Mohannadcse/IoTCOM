
// filename: cap_lock.als
module cap_lock
open IoTBottomUp
one sig cap_lock extends Capability {}
{
    attributes = cap_lock_attr
}
abstract sig cap_lock_attr extends Attribute {}
one sig cap_lock_attr_lock extends cap_lock_attr {}
{
    values = cap_lock_attr_lock_val
} 
abstract sig cap_lock_attr_lock_val extends AttrValue {}
one sig cap_lock_attr_lock_val_locked extends cap_lock_attr_lock_val {}
one sig cap_lock_attr_lock_val_unknown extends cap_lock_attr_lock_val {}
one sig cap_lock_attr_lock_val_unlocked extends cap_lock_attr_lock_val {}
one sig cap_lock_attr_lock_val_unlocked_with_timeout extends cap_lock_attr_lock_val {}
