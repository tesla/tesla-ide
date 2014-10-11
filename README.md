# How to build your own Eclipse distribution

Right now if you want to build your own Eclipse distribution edit the `product.yml` file and run the following command:

```
./product.rb
```

This will generate all the appropriate Maven build files and then you run:

```
mvn clean package
```

This will give you an Eclipse distribution in the `io.tesla.ide.rcp.product` project in the `target` director

This is a bit of a hack right now because the POMs, product and feature files are generated for the Tycho build that produces the distribution, but there is still a directory that contains static resources. Eventually I would like to bundle up the static resources in a resource bundle that can be configured, but for now it is what it is. You can create your own custom Eclipse distribution it's just not 100% parameterized.

Here's a full example of what a product file might look like:

```
#
# This generates everything needed to create a distributions
#
# https://git.eclipse.org/c/epp/org.eclipse.epp.packages.git/tree/packages/org.eclipse.epp.package.rcp.feature/feature.xml

productId: io.tesla.ide.rcp.product

repos: 
 - 
   id: eclipse
   url: http://download.eclipse.org/releases/kepler 

platforms:
 - osx

featureSets: 
 -
  eclipse:
   features:
    - id: org.eclipse.platform
    - id: org.eclipse.platform.source
    - id: org.eclipse.rcp
    - id: org.eclipse.rcp.source
    - id: org.eclipse.jdt
    - id: org.eclipse.jdt.source
    - id: org.eclipse.pde
    - id: org.eclipse.pde.source
    - id: org.eclipse.equinox.p2.user.ui
    - id: org.eclipse.help
    - id: org.eclipse.egit
    - id: org.eclipse.jgit
    - id: org.eclipse.wb.core.feature
    - id: org.eclipse.wb.core.ui.feature
    - id: org.eclipse.wb.layout.group.feature
    - id: org.eclipse.wb.swt.feature
    - id: org.eclipse.wb.rcp.feature   
    - id: org.eclipse.mylyn.github.feature     
 -  
  m2eclipse:
   features:
    - id: io.tesla.ide.feature
    - id: org.eclipse.m2e.feature
    - id: org.eclipse.m2e.logback.feature
 -    
  m2eTycho:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-tycho/0.7.0/N/0.7.0.201302171659
   features:  
    - id: org.sonatype.tycho.m2e.feature
 -    
  sourcelookup:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/sourcelookup/1.1.0/N/1.1.0.201305050326
   features:  
    - id: com.ifedorenko.m2e.sourcelookup.feature
 -    
  tychodev:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/tychodev/0.2.0/N/0.2.0.201305091121/
   features:  
    - id: com.ifedorenko.m2e.tychodev.feature
 -    
  plexus:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-plexus/0.15.0/N/0.15.0.201302101151
   features:  
    - id: org.sonatype.m2e.plexus.annotations.feature
 -    
  modello:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-modello/0.16.0/N/0.16.0.201302171621
   features:  
    - id: org.sonatype.m2e.modello.feature
 -    
  sisu:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-sisu/0.15.0/N/0.15.0.201207090126/
   features:  
    - id: org.sonatype.m2e.sisu.feature
 -    
  mavenarchiver:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-mavenarchiver/0.15.0/N/0.15.0.201212080009/
   features:  
    - id: org.sonatype.m2e.mavenarchiver.feature
 -    
  m2eEgit:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-egit/0.14.0/N/0.14.0.201305250025/
   features:  
    - id: org.sonatype.m2e.egit.feature
 -    
  m2eAntlr:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-antlr/0.15.0/N/0.15.0.201302040035/
   features:  
    - id: org.sonatype.m2e.antlr.feature
 -    
  nexuside:
   repo: http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/nexuside/1.0.0/N/1.0.0.201303100224/
   features:  
    - id: com.ifedorenko.m2e.nexusdev.feature
 -    
  yedit:
   repo: http://dadacoalition.org/yedit/
   features:  
    - id: org.dadacoalition.yedit
 -    
  workspacemechanic:
   repo: http://workspacemechanic.eclipselabs.org.codespot.com/git.update/mechanic/    
   features:  
    - id: com.google.eclipse.mechanic
 -    
  vjet:
   repo: http://download.eclipse.org/vjet/updates-0.10   
   features:  
    - id: org.eclipse.vjet.core
 -    
  jrebel:
   repo: http://update.zeroturnaround.com/update-site/
   features:  
    - id: org.zeroturnaround.eclipse.feature
    - id: org.zeroturnaround.eclipse.m2e.feature
```