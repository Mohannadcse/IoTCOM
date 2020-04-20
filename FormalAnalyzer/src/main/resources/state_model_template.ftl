module IoTStateModel

open IoTBottomUp as base
open IoTChannel  as chan
open util/ordering[System] as trace

open cap_runIn

<#list apps as app>
open app_${app}
</#list>

sig System {
  state  : set Capability -> (Attribute -> AttrValue),
  rules  : set Rule,
  fails  : set Rule,
  events : set Event
} {
  no (rules & fails)
  all c : Capability | some c.attributes => c in state.univ.univ
  all c : state.univ.univ {
    state[c].univ in c.attributes
    all a : c.attributes {
      (some a.values) => (state[c][a] in a.values) else (a not in state[c].univ)
    }
  }
}

sig Event {
  capability : one Capability,
  attribute  : one Attribute,
  value      : one AttrValue
} {
  attribute in capability.attributes
  value     in attribute.values
}

fact first_system_has_no_event_or_rule {
  no  trace/first.events
  no  trace/first.rules
  no  trace/first.fails
}

fact all_subsequent_systems_have_an_event_or_rule {
  all sys : (System - trace/first) | (some sys.events or some sys.rules)
}

fact no_capability_attribute_value_has_more_than_one_event {
  all e : Event | no e' : Event - e {
    e.capability = e'.capability
    e.attribute  = e'.attribute
    e.value      = e'.value
  }
}

fact no_capability_attribute_has_more_than_one_event_per_state {
  all sys : System, e : sys.events | no e' : sys.events - e {
    e.capability = e'.capability
    e.attribute  = e'.attribute
  }
}

pred satisfies_event[sys : System, e : Event] {
  sys.state[e.capability] != e.attribute -> e.value
}

pred satisfies_rule[sys : System,r : Rule] {
  no r.triggers or event_satisfies_trigger[sys,r] or rule_satisfies_trigger[sys,r]
  all c : r.conditions, cap : c.capabilities |
    sys.state[cap][c.attribute] in c.value
}

pred event_satisfies_trigger[sys : System, r : Rule] {
  some e : sys.events, t : r.triggers {
    e.capability in t.capabilities
    e.attribute  =  t.attribute
    e.value      in t.value or no t.value
  }
}

pred rule_satisfies_trigger[sys : System, r : Rule] {
  some comm : sys.rules.commands, trig : r.triggers {
    some (comm.capability & trig.capabilities)
    comm.attribute = trig.attribute
    (comm.value in trig.value) or no trig.value
  }
}

fact all_executed_events_are_satisfied {
  all sys : (System - trace/first), e : sys.events |
    satisfies_event[sys.prev,e]
}

fact all_executed_rules_are_satisfied {
  all sys : (System - trace/first), r : sys.rules |
    satisfies_rule[sys.prev,r]
}

fact all_failed_rules_have_a_blocker {
  all sys : (System - trace/first), r : sys.fails {
    satisfies_rule[sys.prev,r]
    some c : sys.rules.commands, c' : r.commands {
      c.capability =  c'.capability
      c.attribute  =  c'.attribute
    }
  }
}

fact all_satisfied_rules_are_executed {
  all sys : (System - trace/first), r : Rule |
    satisfies_rule[sys.prev,r] => (r in (sys.rules + sys.fails))
}

fact events_are_applied {
  all sys : (System - trace/first), e : sys.events |
    sys.state[e.capability] = e.attribute -> e.value
}

fact rules_are_applied {
  all sys : (System - trace/first), c : sys.rules.commands |
    sys.state[c.capability] = c.attribute -> c.value
}

fact nothing_changed_except_the_rules_and_events {
  all cap : Capability, sys : (System - trace/first) {
    (sys.state[cap] = sys.prev.state[cap])
      or
    (one c : sys.rules.commands | cap = c.capability and sys.state[cap] = c.attribute -> c.value)
      or
    (one e : sys.events         | cap = e.capability and sys.state[cap] = e.attribute -> e.value)
      or
    (cap in cap_runIn and sys.state[cap][cap_runIn_attr_runIn] = cap_runIn_attr_runIn_val_off and sys.prev.state[cap][cap_runIn_attr_runIn] = cap_runIn_attr_runIn_val_on)
  }
}

fact runIn_lasts_one_step {
  all c : cap_runIn, sys : System | sys.state[c][cap_runIn_attr_runIn] = cap_runIn_attr_runIn_val_on =>
    sys.next.state[c][cap_runIn_attr_runIn] = cap_runIn_attr_runIn_val_off
}

assert t1 { // chain triggering
  no s : System, r' : Rule {
    satisfies_rule[s,r']
    some comm : s.rules.commands, trig : r'.triggers {
      ({
        (some comm.capability & trig.capabilities)
        (comm.attribute = trig.attribute)
        (comm.value in trig.value) or (no trig.value)
      }) or ({
        some c : Channel {
          some (comm.capability   & c.actuators)
          some (trig.capabilities & c.sensors)
        }
      })
    }
  }
}

assert t2 { // condition enabling
  no sys : System, r' : Rule {
    all c : r'.conditions, cap : c.capabilities |
      sys.state[cap][c.attribute] in c.value
    some comm : sys.rules.commands, cond : r'.conditions {
      (some comm.capability & cond.capabilities)
      (comm.attribute = cond.attribute)
    }
  }
}

assert t3 { // condition disabling
  no sys : System, r' : Rule {
    some c : r'.conditions, cap : c.capabilities |
      sys.state[cap][c.attribute] not in c.value
    some comm : sys.rules.commands, cond : r'.conditions {
      (some comm.capability & cond.capabilities)
      (comm.attribute = cond.attribute)
    }
  }
}

assert t4 { // loop triggering
  no sys : System, r : sys.(rules + fails) | r in sys.^prev.rules
}

assert t5 { // conflicting actions
  no System.fails
}

assert t6 { // repeated actions
  no sys : System, disj c,c' : sys.rules.commands {
    some c.capability & c'.capability
    c.attribute = c'.attribute
    c.value = c'.value
  }
}

assert t7 { // guaranteed actions
  no r : Rule, sys, sys' : System {
    r in sys.rules
    r in sys'.rules
    some e : sys.events, e' : sys'.events {
      e.capability = e'.capability
      e.attribute  = e'.attribute
      e.value     != e'.value
    }
  }
}

check t1 for 0 but 10 System, 9 Event
check t2 for 0 but 10 System, 9 Event
check t3 for 0 but 10 System, 9 Event
check t4 for 0 but 10 System, 9 Event
check t5 for 0 but 10 System, 9 Event
check t6 for 0 but 10 System, 9 Event
check t7 for 0 but 10 System, 9 Event
