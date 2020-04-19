
# Overview

In this repository you will find the protype code of IoTCOM, a model-checking tool to verify the safety of IoT Apps.

This work is published at *ACM SIGSOFT International Symposium on Software Testing and Analysis (ISSTA'20)*.

# Code Structure

![picture](images/SystemOverview_V8.png)


# IoTCOM_StaticAnalysis




# Using IoTCOM Static Analysis Part

1. Create an Eclipse project and clone this repository (you can find the instructions [here](https://github.com/collab-uniba/socialcde4eclipse/wiki/How-to-import-a-GitHub-project-into-Eclipse)).
  1. Install Groovy plugin on Eclipse following the instructions at [here](https://github.com/groovy/groovy-eclipse/wiki)
  2. Add all libraries (.jar files) in the "IoTSan/lib" folder.

2. Run the "IotSan.java" as "Java Application". The resulting Promela model code will be generated and stored at ".../IoTSan/output/IotSanOutput/birc".
