module app_${appName}

<#list appCapabilities as cap>
open cap_${cap.id}
</#list>

lone sig app_${app.name} extends IoTApp {
  <#list appProperties as prp>
  // prp.cardinality:
  //   <nothing> => one
  //   optional  => lone
  //   multiple  => some
  //   <both>    => set
  ${prp.name} : ${prp.cardinality} ${prp.type},
  </#list>
} {
  rules = r
}

one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}

<#list appStateAttributes as state_attr>
one sig cap_state_attr_${state_attr.name} extends cap_state_attr {} {
  values = cap_state_attr_${state_attr.name}_val
}
abstract sig cap_state_attr_${state_attr.name}_val extends AttrValue {}

<#list state_attrValues as state_attr_val>
one sig cap_state_attr_${state_attr.name}_val_${state_attr_val} extends cap_state_attr_${state_attr.name}_val {}
</#list>
</#list>

// application rules base class
abstract sig r extends Rule {}

<#list appRules as rule>
one sig r${rule?index} extends r {}{
  triggers   = r${rule?index}_trig
  conditions = r${rule?index}_cond
  commands   = r${rule?index}_comm
}

abstract sig r${rule?index}_trig extends Trigger {}
<#list ruleTriggers as trig>
one sig r${rule?index}_trig${trig?index} extends r${rule?index}_trig {} {
  capabilities = ${trig.capabilities}
  attribute    = ${trig.attribute}
  value        = ${trig.value}
}
</#list>

abstract sig r${rule?index}_cond extends Condition {}
<#list ruleConditions as cond>
one sig r${rule?index}_cond${cond?index} extends r${rule?index}_cond {} {
  capabilities = ${cond.capabilities}
  attribute    = ${cond.attribute}
  value        = ${cond.value} 
}
</#list>

abstract sig r${rule?indeX}_comm extends Command {}
<#list ruleCommands as comm>
one sig r${rule?index}_comm${comm?index} extends r${rule?index}_comm {} {
  capability   = ${comm.capability}
  attribute    = ${comm.attribute}
  value        = ${comm.value}
}
</#list>
</#list>







  <#assign key = state_attr.name/>

  <#list stateAttrValues as propName>
  <#assign n = propName/>
    <#if key == n>
      <#list stateAttrValues[propName] as pv>
      one sig cap_state_attr_${state_attr.name}_val_${pv} extends cap_state_attr_${state_attr.name}_val {}
      </#list>
    </#if>
  </#list>
