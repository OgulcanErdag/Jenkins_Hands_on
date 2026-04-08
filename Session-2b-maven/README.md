# Hands-on Jenkins-03: Java and Maven Jobs in Jenkins

The purpose of this hands-on training is to learn how to install Java and Maven on the Jenkins Server and configure Maven/Java Jobs.

## Learning Outcomes

At the end of this hands-on training, students will be able to;

- Install and configure Maven,

- Create Java and Maven jobs

## Outline

- Part 1 - Install Java, Maven, and Git packages

- Part 2 - Maven Settings

- Part 3 - Creating Package Application - Free Style Maven Job

- Part 4 - Configuring Jenkins Pipeline with GitHub Webhook to Build a Java Maven Project

## Part 1 - Install Java, Maven, and Git packages

- Connect to the Jenkins Server
- Install the JDK for Amazon Corretto 17

```bash
sudo dnf update -y
sudo dnf install java-21-amazon-corretto-devel
```

- Install Maven

```bash
sudo su
cd /opt
rm -rf maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.tar.gz
tar -zxvf $(ls | grep apache-maven-*-bin.tar.gz)
rm -rf $(ls | grep apache-maven-*-bin.tar.gz)
ln -s $(ls | grep apache-maven*) maven
echo 'export PATH=/opt/maven/bin:${PATH}' >> /etc/profile.d/maven.sh
exit
source /etc/profile.d/maven.sh
```

- Install Git

```bash
sudo dnf install git -y
```

## Part 2 - Maven Settings

- Open Jenkins GUI on a web browser

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
  - Give a name such as `maven-3.9.9`
  - Select `install automatically`
  - `Install from Apache` version `3.9.9`
- Save

## Part 3 - Creating Package Application - Free Style Maven Job

- Select `New Item`

- Enter name as `package-application`

- Select `Free Style Project`

```yaml
- General:
- Description: This Job is packaging the Java-Tomcat-Sample Project and creates a war file.

- Discard old builds:
   Strategy:
     Log Rotation:
       Days to keep builds: 5
       Max#of builds to keep: 3

- Source Code Management:
    Git:
      Repository URL: https://github.com/clarusway-aws-devops/java-tomcat-sample-main.git

    Branches to build: Go to the web browser and check the branch name of the git project `https://github.com/clarusway-aws-devops/java-tomcat-sample-main.git`.

- It is a public repo, no need for `Credentials`.

- Build Environments:
   - Delete workspace before build starts
   - Add timestamps to the Console Output

- Build Steps:
    Invoke top-level Maven targets:
      - Maven Version: maven-3.9.9
      - Goals: clean package
  - POM: pom.xml

- Post-build Actions:
    Archive the artifacts:
      Files to archive: **/*.war
```

- Finally, `Save` the job.

- Select `package-application`

- Click the `Build Now` option.

- Observe the Console Output

## Part 4 - Configuring Jenkins Pipeline with GitHub Webhook to Build a Java Maven Project

- To build the `Java Maven project` with Jenkins pipeline using the `Jenkinsfile` and `GitHub Webhook`. To accomplish this task, we need;
  - a Java code to build

  - a Java environment to run the build stages on the Java code

  - a Maven environment to run the build stages on the Java code

  - a Jenkinsfile configured for an automated build on our repo

- Create a public project repository `jenkins-maven-project` on your GitHub account.

- Clone the `jenkins-maven-project` repository on the local computer.

- Copy the files given within the hands-on folder [hello-app](./hello-app) and paste them under the `jenkins-maven-project` GitHub repo folder.

- Go to your GitHub `jenkins-maven-project` repository page and click on `Settings`.

- Click on the `Webhooks` on the left-hand menu, and then click on `Add webhook`.

- Copy the Jenkins URL from the AWS Management Console, paste it into the `Payload URL` field, add `/github-webhook/` at the end of the URL, and click on `Add webhook`.

```bash
http://ec2-54-144-151-76.compute-1.amazonaws.com:8080/github-webhook/
```

- Go to the Jenkins dashboard and click on `New Item` to create a pipeline.

- Enter `pipeline-with-jenkinsfile-and-webhook-for-maven-project` then select `Pipeline` and click `OK`.

```yaml
- General:
- Description: Simple pipeline configured with Jenkinsfile and GitHub Webhook for a Maven project

- Build Triggers:
    - GitHub hook trigger for GitScm polling

- Pipeline:
    Definition:
      Pipeline script from SCM:
        Git:
          Repository URL:
            - https://github.com/<your_github_account_name>/jenkins-maven-project/

          Branches to build: It must be the same branch name as your `jenkins-first-webhook-project` GitHub repository. If your repository's default branch name is "main", then change "master" to "main".
```

- Click `apply` and `save`. Note that the script `Jenkinsfile` should be placed under the root folder of the repo.

- Create a `Jenkinsfile` with the following pipeline script, and explain the script.

- For a native structured Jenkins Server

```groovy
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'mvn -f hello-app/pom.xml test'
            }
            post {
                always {
                    junit 'hello-app/target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -f hello-app/pom.xml -B -DskipTests clean package'
            }
            post {
                success {
                    echo "Now Archiving the Artifacts....."
                    archiveArtifacts artifacts: '**/*.jar'
                }
            }
        }
    }
}
```

- Commit and push the changes to the remote repo on GitHub.

```bash
git add .
git commit -m 'added Jenkinsfile and Maven project'
git push
```

- Observe the newly built triggered with the `git push` command on the Jenkins project page.
