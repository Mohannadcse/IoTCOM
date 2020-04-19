module app_${appName}

open IoTBottomUp as base

<#list appCapabilities as cap>
open cap_${cap.id}
</#list>

<#if appTouch == "yes">
open cap_app
</#if> 

one sig app_${appName} extends IoTApp {
  <#list appProperties as prp>
  <#-- // prp.cardinality:
  //   <nothing> => one
  //   optional  => lone
  //   multiple  => some
  //   <both>    => set -->
  
  ${prp.name} : ${prp.cardinality} ${prp.type},
  </#list>
} {
  rules = r
  <#-- ${allCap} -->
}

<#list userInputList as input>
${input}
</#list>

<#list userCapSet as input>
one sig cap_userInput_attr_${input} extends cap_userInput_attr {}
{
    values = cap_userInput_attr_${input}_val
} 
abstract sig cap_userInput_attr_${input}_val extends cap_userInput_attr_value_val {}
</#list>

<#if specCapSize == "NotEmpty">
one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}
</#if>  

<#list stateAttrValues?keys as groupKey>

one sig cap_state_attr_${groupKey} extends cap_state_attr {} {
  values = cap_state_attr_${groupKey}_val
}

abstract sig cap_state_attr_${groupKey}_val extends AttrValue {}
<#list stateAttrValues[groupKey] as item>
one sig cap_state_attr_${groupKey}_val_${item} extends cap_state_attr_${groupKey}_val {}
</#list>
</#list>

<#list nowValues as v>
${v}
</#list>

<#list ranges as r>
one sig ${r.range} extends cap_${r.capabilities}_attr_${r.attribute}_val {}
</#list>

// application rules base class

abstract sig r extends Rule {}

<#list triggers?keys as groupKey>
one sig r${groupKey} extends r {}{
<#if triggers[groupKey]?size == 0>
  no triggers
<#else>
  triggers   = r${groupKey}_trig
</#if> 
  conditions = r${groupKey}_cond
  commands   = r${groupKey}_comm
}

<#if triggers[groupKey]?size != 0>
abstract sig r${groupKey}_trig extends Trigger {}
</#if> 

<#list triggers[groupKey] as trig>
one sig r${groupKey}_trig${trig?index} extends r${groupKey}_trig {} {
  capabilities = app_${appName}.${trig.obj}
  attribute    = cap_${trig.capabilities}_attr_${trig.attribute}
  <#if trig.value == "no_value">
  <#-- value        = cap_${trig.capabilities}_attr_${trig.attribute}_val -->
  no value
  <#elseif trig.app == "1">
  value        = app_${appName}.${trig.value} 
  <#else>
  value        = cap_${trig.capabilities}_attr_${trig.attribute}_val_${trig.value}
  </#if>
}
</#list>


abstract sig r${groupKey}_cond extends Condition {}

<#list conditions[groupKey] as cond>
one sig r${groupKey}_cond${cond?index} extends r${groupKey}_cond {} {
  capabilities = app_${appName}.${cond.obj}
  attribute    = cap_${cond.capabilities}_attr_${cond.attribute}
  <#if cond.app == "1">
    <#assign val = "app_${appName}.${cond.value}">
  <#else>
    <#assign val = "cap_${cond.capabilities}_attr_${cond.attribute}_val_${cond.value}">
  </#if>
  <#if cond.neg == "1">
  value        = cap_${cond.capabilities}_attr_${cond.attribute}_val - ${val}
  <#else>
  <#if cond.value != "no_value">
  value        = cap_${cond.capabilities}_attr_${cond.attribute}_val_${cond.value}
  <#else>
  value        = cap_${cond.capabilities}_attr_${cond.attribute}_val
  </#if>
  </#if>  
}
</#list>

abstract sig r${groupKey}_comm extends Command {}

<#list commands[groupKey] as comm>
one sig r${groupKey}_comm${comm?index} extends r${groupKey}_comm {} {
  capability   = app_${appName}.${comm.capabilities}
  <#if comm.loc == "0">
    <#assign attr = "cap_${comm.attribute}_attr_${comm.attribute}" >
  <#else>
    <#assign attr = "cap_${comm.capabilities}_attr_${comm.attribute}" >
  </#if>
  attribute = ${attr}
  <#if comm.value == "no_value">
  <#if comm.loc == "0" >
  value = cap_${comm.attribute}_attr_${comm.attribute}_val
  <#else>
  value = cap_${comm.capabilities}_attr_${comm.attribute}_val
  </#if>
  <#elseif comm.app == "1" >
  value        = app_${appName}.${comm.value}
  <#else>
  <#if comm.loc == "0" >
  value = cap_${comm.attribute}_attr_${comm.attribute}_val_${comm.value}
  <#else>
  value = cap_${comm.capabilities}_attr_${comm.attribute}_val_${comm.value}
  </#if>
  </#if>
}
</#list>

</#list>


