module IoTGraphModel

open IoTBottomUp as base
open IoTChannel  as chan

open cap_runIn
open cap_lock
open cap_switch
open cap_temperatureMeasurement
open cap_presenceSensor
open cap_motionSensor
open cap_location
open cap_contactSensor
open cap_smokeDetector
open cap_alarm
open cap_doorControl

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

// P1: DON'T turn off the Heater WHEN temperature is low and location mode is Night
assert P1 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn off the Heater..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when mode is night
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Night
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when we go away
    event.attribute = cap_temperatureMeasurement_attr_temperature
      event.value     = cap_temperatureMeasurement_attr_temperature_val_low
    })
  }
}

// P2: DON'T turn on the AC WHEN location mode is Away
assert P2 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the AC..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
  }
}

// P3: DON'T turn on The bedroom’s light WHEN the bedroom’s door is closed
assert P3 {
  no r : IoTApp.rules, action : r.commands {
    // "DON'T turn on The bedroom’s light..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...or if door is locked ****
      action'.attribute = cap_lock_attr_lock
      action'.value     = cap_lock_attr_lock_val_locked
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the door closed
      event.attribute = cap_contactSensor_attr_contact
      event.value     = cap_contactSensor_attr_contact_val_closed
    })
  }
}

// P4: DON'T unlock The main door WHEN location mode is Away
assert P4 {
  no r : IoTApp.rules, action : r.commands {
    // "DON'T unlock The main door..."
    action.attribute = cap_lock_attr_lock
    action.value     = cap_lock_attr_lock_val_unlocked

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when someone is away
    action'.attribute   = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if motion is inactive 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the user no present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
    or 
    (some predecessor : r.*(~connected), cond : predecessor.conditions {
      // ...There is a possibility the condition mandates the action of a certain trigger
      cond.attribute = cap_presenceSensor_attr_presence
      cond.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

// P5: DON'T turn off The living room’s bulb WHEN someone is at home
assert P5 {
  no r : IoTApp.rules, action : r.commands {
    // "DON'T turn off The living room’s bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when someone is at home
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Home 
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if motion is active 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_active
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the user no present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_present
    })
  }
}

// P6: DON'T turn off The AC at night when temperature is high
assert P6 {
  no r : IoTApp.rules, action : r.commands {
    // "DON'T turn off AC..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when no motion in the living room
      event.attribute = cap_temperatureMeasurement_attr_temperature
      event.value     = cap_temperatureMeasurement_attr_temperature_val_high 
    }) 
  }
}

// P7: DON'T switch on A dim bulb WHEN no one is at home and there is no motion in the living room
assert P7 {
  no r : IoTApp.rules, action : r.commands {
    // "DON'T switch on A dim bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when no one is at home
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val - cap_location_attr_mode_val_Home
    }) 
    and
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when no motion in the living room
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
  }
}

// P8: DON'T switch off The water valve WHEN smoke is detected  //IoTSAN used switch instead of valve
assert P8 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the living room’s bulb..."
    action.attribute = cap_switch_attr_switch 
    action.value     = cap_switch_attr_switch_val_on
    
    or 
    
    action.attribute = cap_valve_attr_valve
    action.value     = cap_valve_attr_valve_val_closed

    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when smoke is detected
      event.attribute = cap_smokeDetector_attr_smoke
      event.value     = cap_smokeDetector_attr_smoke_val_detected
    }) 
  }
}

assert P9 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn off the living room’s bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
  or
  (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go vacation
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Vacation
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when motion is inactive 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if user not present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

// P10: DON'T turn on living room’s bulb at night WHEN no one is at home and vacation mode //it's weired how IoTSAN uses cap_switch to indicate vacation mode
assert P10 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the living room’s bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
  or
  (some predecessor : r.*(~connected), action' : predecessor.commands {
    // ...when we go vacation
    action'.attribute = cap_location_attr_mode
    action'.value     = cap_location_attr_mode_val_Vacation
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when motion is inactive 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if user not present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

assert P11 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn off the living room’s bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
  or
  (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go vacation
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Vacation
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when motion is inactive 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if user not present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

// P12: DON'T turn on a dim bulb WHEN no one is at home //Similar to P7
assert P12 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the dim bulb..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when motion is inactive 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if user not no present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

// P13: change location mode to Away WHEN no one is at home
assert P13 {
  no r : IoTApp.rules, action : r.commands {
    // location mode should be Away...
    action.attribute = cap_location_attr_mode
    action.value     != cap_location_attr_mode_val_Away

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when motion is inactive 
      action'.attribute = cap_motionSensor_attr_motion
      action'.value     = cap_motionSensor_attr_motion_val_inactive
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the user no present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

// P14: change location mode to Home WHEN some one is at home
assert P14 {
  no r : IoTApp.rules, action : r.commands {
    // "location mode should be home..."
    action.attribute = cap_location_attr_mode
    action.value     != cap_location_attr_mode_val_Home

    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when motion is active 
      event.attribute = cap_motionSensor_attr_motion
      event.value     = cap_motionSensor_attr_motion_val_active
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the user present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_present
    })
  }
}

// P15: DON'T turn on the heater WHEN we go away or if the door opens
assert P15 {
  // location.mode = away
  // lock.lock = unlocked (contactSensor.contact = open)
  // switch.switch = off (heater)
  // "don't turn on the heater when we go away or if the door opens"
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the heater..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_on

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Away
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the door opens
      event.attribute = cap_contactSensor_attr_contact
      event.value     = cap_contactSensor_attr_contact_val_open
    })
  }
}

// P16: DON'T open the door WHEN we go away
assert P16 {
  no r : IoTApp.rules, action : r.commands {
    action.attribute = cap_contactSensor_attr_contact
    action.value     = cap_contactSensor_attr_contact_val_open

    (some predecessor : r.*(~connected), action' : predecessor.commands {
      // ...when we go away
      action'.attribute = cap_location_attr_mode
      action'.value     = cap_location_attr_mode_val_Home
    }) 
    or 
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the door opens
      event.attribute = cap_smokeDetector_attr_smoke
      event.value     = cap_smokeDetector_attr_smoke_val_detected
    })
  }
}

/* P17: DON'T turn off the Security device WHEN user is not present */
assert P17 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn off Security device..."
    action.attribute = cap_switch_attr_switch
    action.value     = cap_switch_attr_switch_val_off

    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...or if the user no present
      event.attribute = cap_presenceSensor_attr_presence
      event.value     = cap_presenceSensor_attr_presence_val_not_present
    })
  }
}

/* P18: DON'T turn off The alarm WHEN smoke is detected */  
assert P18 {
  no r : IoTApp.rules, action : r.commands {
    // "don't turn on the living room’s bulb..."
    action.attribute = cap_alarm_attr_alarm 
    action.value     = cap_alarm_attr_alarm_val_off

    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when smoke is detected
      event.attribute = cap_smokeDetector_attr_smoke
      event.value     = cap_smokeDetector_attr_smoke_val_detected
    }) 
  }
}

/* P19: Intensity changed and door unlocked (covert attack)*/
//I need to define another property because the two command can be executed using one rule
assert P19 {
  no r,r' : IoTApp.rules {
    some cmd : r.commands, cmd' : r'.commands {
      (cmd != cmd')
      (cmd.attribute  = cap_switchLevel_attr_level)
      (cmd'.attribute = cap_lock_attr_lock)
      (cmd'.value      = cap_lock_attr_lock_val_unlocked)
    }
    // there is some descendant of r that is the same as or a
    // sibling to some descendant of r'
    some a : r.*(~connected), a' : r'.*(~connected) {
      (a = a') or (are_siblings[a,a'])
    }
  }
}

/* P20: DON'T lock the door WHEN smoke is detected*/
assert P20 {
  no r : IoTApp.rules, action : r.commands {
    action.attribute = cap_lock_attr_lock 
    action.value     = cap_lock_attr_lock_val_locked
    /*
    (some predecessor : r.*(~connected), event : predecessor.triggers {
      // ...when smoke is detected
      event.attribute   = cap_smokeDetector_attr_smoke
      //event.value     = cap_smokeDetector_attr_smoke_val_detected
    }) 
    or
    */
    (some predecessor : r.*(~connected), cond : predecessor.conditions, event : predecessor.triggers {
      // ...when smoke is detected
      //event.attribute = cap_smokeDetector_attr_smoke
      cond.attribute = cap_smokeDetector_attr_smoke
      cond.value     = cap_smokeDetector_attr_smoke_val_detected
    }) 
  }
}

/* DON'T open the door WHEN smoke is detected because of heater*/
assert P21{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_carbonMonoxideDetector_attr_carbonMonoxide)
      (trig.value     = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected)
      (cmd.attribute  = cap_doorControl_attr_door)
      (cmd.value      = cap_doorControl_attr_door_val_open)
    }
    //heater
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T open the unlock the door WHEN smoke is detected because of heater*/
assert P22{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_carbonMonoxideDetector_attr_carbonMonoxide)
      (trig.value     = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected)
      (cmd.attribute  = cap_lock_attr_lock)
      (cmd.value      = cap_lock_attr_lock_val_unlocked)
    }
    //heater
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T open the door WHEN motion is active because of fan*/
assert P23{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_motionSensor_attr_motion)
      (trig.value     = cap_motionSensor_attr_motion_val_active)
      (cmd.attribute  = cap_contactSensor_attr_contact)
      (cmd.value      = cap_contactSensor_attr_contact_val_open)
    }
    //fan
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T unlock the door WHEN motion is active because of fan*/
assert P24{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_motionSensor_attr_motion)
      (trig.value     = cap_motionSensor_attr_motion_val_active)
      (cmd.attribute  = cap_lock_attr_lock)
      (cmd.value      = cap_lock_attr_lock_val_unlocked)
    }
    //fan
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T open the door/window WHEN tempreature is changed*/
assert P25{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_temperatureMeasurement_attr_temperature)
      //(trig.value     = cap_temperatureMeasurement_attr_temperature)
      (cmd.attribute  = cap_switch_attr_switch)
      (cmd.value      = cap_switch_attr_switch_val_on)
    }
    //thermostat
    some cmd': r'.commands {
      (cmd'.attribute = cap_thermostat_attr_thermostat_val)
      //(cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T change location mode WHEN tempreature is changed*/
assert P26{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute = cap_temperatureMeasurement_attr_temperature)
      //(trig.value     = cap_temperatureMeasurement_attr_temperature)
      (cmd.attribute  = cap_location_attr_mode)
      //(cmd.value      = cap_switch_attr_switch_val_on)
    }
    //heater
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}


/* DON'T change location mode WHEN smoke is detected*/
assert P27{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute   = cap_carbonMonoxideDetector_attr_carbonMonoxide)
      (trig.value     = cap_carbonMonoxideDetector_attr_carbonMonoxide_val_detected)
      (cmd.attribute    = cap_location_attr_mode)
    }
    //toaster
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value = cap_switch_attr_switch_val_on)
    }
  }
}

/* DON'T switch on bulb/heater WHEN iluminance is changed*/
assert P28{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute   = cap_illuminanceMeasurement_attr_illuminance)
      (cmd.attribute    = cap_switch_attr_switch)
      (cmd.value      = cap_switch_attr_switch_val_on)
    }
    //bulb
    some cmd': r'.commands {
      (cmd'.attribute = cap_switch_attr_switch)
      (cmd'.value     = cap_switch_attr_switch_val_on)
    }
  }
}


/* DON'T change mode WHEN motion is active because of alarm siren*/
assert P29{
  no r, r' : IoTApp.rules {
    some cmd : r.commands, trig : r.triggers {
      (trig.attribute   = cap_motionSensor_attr_motion)
      (trig.value     = cap_motionSensor_attr_motion_val_active)
      (cmd.attribute    = cap_location_attr_mode)
    }
    //alarm
    some cmd': r'.commands {
      (cmd'.attribute = cap_alarm_attr_alarm)
      (cmd'.value     = cap_alarm_attr_alarm_val_siren)
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

//Specific Policies
check P1
check P2
check P3
check P4
check P5
check P6
check P7
check P8
check P9
check P10
check P11
check P12
check P13
check P14
check P15
check P16
check P17
check P18
check P19
check P20
check P21
check P22
check P23
check P24
check P25
check P26
check P27
check P28
check P29
