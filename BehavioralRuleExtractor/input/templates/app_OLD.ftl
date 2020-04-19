module IoT_UnlockDoor

open IoTCapabilities

lone sig ${appName} extends IoTApp {
	${app.rules}
}


<#list appRules as rule>
one sig ${rule.name} extends Rule {}{
	${rule.trigger}
	${rule.condition}
	${rule.command}
}

</#list>

<#list appTriggers as trigger>
one sig ${trigger.name} extends Trigger {} {
	${trigger.cap} 
	${trigger.attr} 
	${trigger.attrVal} 
}
</#list>

<#list appConditions as condition>
one sig ${condition.name} extends Condition {} {
	capabilities	= GoodNight_App.motionSensors
	attribute		= MotionAttr
	value			= MotionAttr_Inactive
}
</#list>

<#list appCommands as command>
one sig ${command.name} extends Command {} {
	${command.cap} 
	${command.attr} 
	${command.cmdVal}
}
</#list>





