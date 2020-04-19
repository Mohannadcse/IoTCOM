module app_${appName}

open IoTBottomUp as base

<#list appCapabilities as cap>
open cap_${cap}
</#list>

lone sig app_${appName} extends IoTApp {
  <#list appProperties as prp>
  ${prp.name} : ${prp.cardinality} ${prp.type},
  </#list>
} {
  rules = r
}


// application rules base class

abstract sig r extends Rule {}

<#list triggers?keys as groupKey>
one sig r${groupKey} extends r {}{
  triggers   = r${groupKey}_trig
  no conditions 
  commands   = r${groupKey}_comm
}

<#if triggers[groupKey]?size != 0>
abstract sig r${groupKey}_trig extends Trigger {}
</#if> 

<#list triggers[groupKey] as trig>
one sig r${groupKey}_trig${trig?index} extends r${groupKey}_trig {} {
  capabilities = app_${appName}.${trig.obj}
  attribute    = cap_${trig.capabilities}_attr_${trig.attribute}
  value        = cap_${trig.capabilities}_attr_${trig.attribute}_val_${trig.value}
}
</#list>


abstract sig r${groupKey}_comm extends Command {}

<#list commands[groupKey] as comm>
one sig r${groupKey}_comm${comm?index} extends r${groupKey}_comm {} {
  capability   = app_${appName}.${comm.capabilities}
  attribute    = cap_${comm.attribute}_attr_${comm.attribute}
  value        = cap_${comm.attribute}_attr_${comm.attribute}_val_${comm.value}
}
</#list>

</#list>


