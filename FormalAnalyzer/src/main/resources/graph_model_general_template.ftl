module IoTGraphModel

open IoTBottomUp as base
open IoTChannel  as chan

open cap_runIn

<#list apps as app>
open app_${app}
</#list>

pred connected_runIn[r,r' : Rule] {
  no r'.triggers
  some comm : r.commands, cond : r'.conditions {
    (cond.attribute  = cap_runIn_attr_runIn)
    (cond.value      = cap_runIn_attr_runIn_val_on)
    (comm.capability = cond.capabilities)
    (comm.attribute  = cond.attribute)
    (comm.value      = cond.value)
  }
}

pred connected_caps[comm : Command, trig : Trigger] {
  (some comm.capability & trig.capabilities)
  (comm.attribute = trig.attribute)
  (comm.value in trig.value) or (no trig.value)
}

pred connected_chan[comm : Command, trig : Trigger] {
  some c : Channel {
    some (comm.capability   & c.actuators)
    some (trig.capabilities & c.sensors)
  }
}

pred are_indirect[r,r' : Rule] {
  are_connected[r,r']
  no comm : r.commands, trig : r'.triggers {
    connected_caps[comm, trig]
  }
}

pred are_connected[r,r' : Rule] {
  (r != r')
  (some comm : r.commands, trig : r'.triggers {
    connected_caps[comm, trig] or connected_chan[comm, trig]
  }) or (connected_runIn[r,r'])
  all comm : r.commands, cond : r'.conditions {
    ((some comm.capability & cond.capabilities) and (comm.attribute = cond.attribute)) => {
      (comm.value in cond.value)
    }
  }
}

pred are_siblings[r,r' : Rule] {
  (no r.triggers) or (no r'.triggers) or (some t : r.triggers, t' : r'.triggers {
    (t.attribute = t'.attribute)
    (some t.value & t'.value) or (no t.value) or (no t'.value)
  })
  all c : r.conditions, c' : r'.conditions {
    ((some c.capabilities & c'.capabilities) and (c.attribute = c'.attribute))
      => (some c.value & c'.value)
  }
}

fact {
  all r,r' : Rule {
    (r' in r.connected) <=> are_connected[r,r']
    (r' in r.siblings)  <=> are_siblings[r,r']
    (r' in r.indirect)  <=> are_indirect[r,r']
    (r' in r.scheduled) <=> connected_runIn[r,r']
  }
}

assert t1 { // chain triggering
    no disj r,r' : IoTApp.rules | r' in (r.connected - r.scheduled)
}

assert t2 { // condition enabling
  no r,r' : IoTApp.rules {
    some comm : r.commands, cond : r'.conditions {
      (cond.attribute != cap_runIn_attr_runIn)
      (some comm.capability & cond.capabilities)
      (comm.attribute = cond.attribute)
      (comm.value in cond.value)
    }
  }
}

assert t3 { // condition disabling
  no r,r' : IoTApp.rules {
    some comm : r.commands, cond : r'.conditions {
      (cond.attribute != cap_runIn_attr_runIn)
      (some comm.capability & cond.capabilities)
      (comm.attribute = cond.attribute)
      (comm.value not in cond.value)
    }
  }
}

assert t4 { // loop triggering
  no r : IoTApp.rules | r in r.^connected
}


assert t5 { // conflicting actions
  no r,r' : IoTApp.rules {
    // the commands are contradictory
    some cmd : r.commands, cmd' : r'.commands {
      (cmd != cmd')
      (some cmd.capability & cmd'.capability)
      (cmd.attribute  = cmd'.attribute)
      (cmd.value     != cmd'.value)
    }
    // there is some descendant of r that is the same as or a
    // sibling to some descendant of r'
    some a : r.*(~connected), a' : r'.*(~connected) {
      (a = a') or (are_siblings[a,a'])
    }
  }
}

assert t6 { // repeated actions
  no r,r' : IoTApp.rules {
    // the commands are identical
    some cmd : r.commands, cmd' : r'.commands {
      (cmd != cmd')
      (some cmd.capability & cmd'.capability)
      (cmd.attribute  = cmd'.attribute)
      (cmd.value      = cmd'.value)
    }
    // there is some ancestor of r that is the same as or a
    // sibling to some ancestor of r'
    some a : r.*(~connected), a' : r'.*(~connected) {
      (a = a') or (are_siblings[a,a'])
    }
  }
}

assert t7 { // guaranteed actions
  no r,r' : IoTApp.rules {
    // the commands are identical
    some cmd : r.commands, cmd' : r'.commands {
      (some cmd.capability & cmd'.capability)
      (cmd.attribute  = cmd'.attribute)
      (cmd.value      = cmd'.value)
    }
    // there is some ancestor of r that is triggered
    // by the complement of some ancestor of r'
    some a : r.*(~connected), a' : r'.*(~connected) {
      (a != a')
      // the triggers are in conflict
      some t : a.triggers, t' : a'.triggers {
        some t.capabilities & t'.capabilities
        t.attribute = t'.attribute
        some t.value
        some t'.value
        no t.value & t'.value
      }
      // the conditions are not mutually exclusive
      all c : a.conditions, c' : a'.conditions {
        ((some c.capabilities & c'.capabilities) and (c.attribute = c'.attribute))
          => (some c.value & c'.value)
      }
    }
  }
}

//Global Policies
check t1
check t2
check t3
check t4
check t5
check t6
check t7
