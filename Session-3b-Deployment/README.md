# Hands-on Jenkins-05: Deploying Application to Staging/Production Environment with Jenkins

The purpose of this hands-on training is to learn how to deploy applications to the Staging/Production Environment with Jenkins.

## Learning Outcomes

At the end of this hands-on training, students will be able to;

- Deploy an application to the Staging/Production Environment with Jenkins

- Automate a Maven project as a pipeline.

## Outline

- Part 1 - Building a Web Application

- Part 2 - Deploy Application to Staging Environment

- Part 3 - Update the application and deploy it to the staging environment

- Part 4 - Deploy the application to the production environment

- Part 5 - Automate Existing Maven Project as Pipeline with Jenkins


- NOTE: your Jenkins instance needs to have mvn as well, and note that it won't get installed with any plugins if you already have it installed

##  - Maven Settings in Jenkins

- Open Jenkins GUI in a web browser

- Setting System Maven Path for default usage
  
- Go to `Manage Jenkins`
  - Select `System`
  - Find `Environment variables` part,
  - Click `Add`
    - for `Name`, enter `PATH+EXTRA` 
    - for `Value`, enter `/opt/maven/bin`
- Save

- Setting a specific Maven Release in Jenkins for usage
  
- Go to the `Tools` at `System Configuration`
- To the bottom, `Maven` section
  - Give a name such as `maven-3.9.11`
  - Select `install automatically`
  - `Install from Apache` version `3.9.11`
- Save


## Part 1 - Building a Web Application

- Select `New Item`

- Enter name as `build-web-application`

- Select `Free Style Project`

```yml
- General:
- Description: This job packages the java-tomcat-sample-main app and creates a war file.

- Discard old builds: 
   Strategy:
     Log Rotation:
       Days to keep builds: 5 
       Max#of builds to keep: 3

- Source Code Management:
    Git:
      Repository URL: https://github.com/clarusway-aws-devops/java-tomcat-sample-main
    Branch Specifier: main
- It is public repo, no need for `Credentials`.

- Build Environments: 
   - Delete workspace before build starts
   - Add timestamps to the Console Output

- Build Steps:
    Invoke top-level Maven targets:
      - Maven Version: maven-3.9.11
      - Goals: clean package
  - POM: pom.xml

- Post-build Actions:
    Archive the artifacts:
      Files to archive: **/*.war 
```

- Finally, `Save` the job.

- Click the `Build Now` option.

- Observe the Console Output

## Part 2 - Deploy Application to Staging Environment



- Select `New Item`

- Enter name as `Deploy-Application-Staging-Environment`

- Select `Free Style Project`

```yml
- Description: This job deploys the java-tomcat-sample-main app to the staging environment.

- Discard old builds: 
   Strategy:
     Log Rotation:
       Days to keep builds: 5 
       Max#of builds to keep: 3

- Build Environments: 
   - Delete workspace before build starts
   - Add timestamps to the Console Output

- Build Steps:
    Copy artifact from another project: # if you don't have the plugin, install it 
      - Project name: build-web-application
      - Which build: Latest successful build
  - Check `Stable build only`
  - Artifact to copy: **/*.war

- Post-build Actions:
    Deploy war/ear to a container: # add plugin as well
      WAR/EAR files: **/*.war
      Context path: /
      Containers: Tomcat 9.x Remote
      Credentials:
        Add: Jenkins
          - username: tomcat
          - password: tomcat
      Tomcat URL: http://<tomcat staging server public ip>:8080
```
- Click on `Save`.

- Go to the `Deploy-Application-Staging-Environment` 

- Click `Build Now`.

- Explain the built results.

- Open the staging server URL with port # `8080` and check the results.

## Part 3 - Update the application and deploy it to the staging environment

-  Go to the `build-web-application`
   -  Select `Configure`
```yml
- Post-build Actions:
    Add post-build action:
      Build other projects:
        Projects to build: Deploy-Application-Staging-Environment
        - Trigger only if the build is stable

- Build Triggers:
    Poll SCM: 
      Schedule: * * * * *
  (You will see the warning `Do you really mean "every minute" when you say "* * * * *"? Perhaps you meant "H * * * *" to poll once per hour`)
```
   - `Save` the modified job.

   - At the `Project build-web-application`  page, you will see `Downstream Projects`: `Deploy-Application-Staging-Environment`

- Update the website content, and commit to GitHub.

- Go to the  `Project build-web-application` and `Deploy-Application-Staging-Environment` pages and observe the auto build & deploy process.

- Explain the built results.

- Open the staging server URL with port # `8080` and check the results.

## Part 4 - Deploy the application to the production environment

- First, run ``the terraform config file`` to provision `tomcat-production-server` from your github repo. This tomcat-production-server will be created from the image of the "tomcat-staging-server".

- Go to the Jenkins server dashboard.

- Select `New Item`

- Enter name as `Deploy-Application-Production-Environment`

- Select `Free Style Project`
```yml
- Description : This job deploys the java-tomcat-sample-main app to the production environment.

- Discard old builds: 
   Strategy:
     Log Rotation:
       Days to keep builds: 5 
       Max#of builds to keep: 3

- Build Environments: 
   - Delete workspace before build starts
   - Add timestamps to the Console Output
   - Color ANSI Console Output Options

- Build Steps:
    Copy artifact from another project:
      - Project name: build-web-application
      - Which build: Latest successful build
  - Check `Stable build only.`
  - Artifact to copy: **/*.war

- Post-build Actions:
    Deploy war/ear to a container:
      WAR/EAR files: **/*.war
      Context path: /
      Containers: Tomcat 9.x Remote
      Credentials: tomcat/*****
      Tomcat URL: http://<tomcat production server public ip>:8080
```
- Click on `Save`.

- Click `Build Now`.

## Part 5 - Automate Existing Maven Project as Pipeline with Jenkins

-  Go to the `build-web-application`
   -  Select `Configure`

```yml
- Post-build Actions:
  *** Remove ---> Build other projects
```

- Go to the Jenkins dashboard and click `New Item` to create a pipeline.

- Enter `build-web-application-code-pipeline` then select `Pipeline` and click `OK`.
```yml
- General:
    Description: This pipeline job packages the java-tomcat-sample-main app and deploys it to both the staging and production environments in the description field.

    - Discard old builds: 
       Strategy:
         Log Rotation:
           Days to keep builds: 5 
           Max#of builds to keep: 3

- Pipeline:
    Definition: Pipeline script from SCM
    SCM: Git
      Repositories:
        - Repository URL: https://github.com/clarusway-aws-devops/java-tomcat-sample-main
        - Branches to build: 
            Branch Specifier: */main

    Script Path: Jenkinsfile
```

- `Save` and `Build Now` and observe the behavior.
