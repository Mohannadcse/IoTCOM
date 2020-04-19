
# Overview

In this repository you will find the protype code of IoTCOM, a model-checking tool to verify the safety of IoT Apps.

This work is published at *ACM SIGSOFT International Symposium on Software Testing and Analysis (ISSTA'20)*.

# IoTCOM Architecture 

IoTCOM comprises two components:

1- Behavioral Rule Extractor (BRE): generates the behavioral models of the IoT apps (groovy and IFTTT).

2- Formal Analyzer (FA): relies on Alloy to perform formal verification to check the safety IoT apps.

![picture](images/SystemOverview_V8.png)


# IoTCOM_Behavioral Rule Extractor

To use this component: 

1. Create an Eclipse project and clone this repository (you can find the instructions [here](https://github.com/collab-uniba/socialcde4eclipse/wiki/How-to-import-a-GitHub-project-into-Eclipse)).
  - Add all libraries (.jar files) in the "IoTCOM_StaticAnalysis/lib" folder.

2. Run the "IotSan.java" as "Java Application". The resulting Alloy models (.als files) will be generated and stored at ".../IoTCOM_StaticAnalysis/output/". The models that are generatd using our tool are in the directory `Dataset_RealWorldApps`
