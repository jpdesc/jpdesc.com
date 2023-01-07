Title: CI/CD Jenkins Project
Author: Jack DesCombes
Date: 2022-12-30

As a continuation of recent forays into automation with Ansible, I decided to up my DevOps game further by creating a Jenkins CI/CD pipeline for my wellness app. This would allow me to automate the testing and deployment of my application, ensuring that code changes aren’t breaking the app’s functionality. Once completed, this project has allowed me greater freedom to devote my time and mental resources on improving the application without having to manually test and troubleshoot its deployment-related processes.

My first steps involved setting up a virtual server with Jenkins and learning how to create and execute simple builds using declarative pipelines, which are used to describe different portions of the software delivery process. After a bit of basic tinkering, I set about creating a specific pipeline to test my application’s code each time I push a new commit, deploying when all functional tests have passed.

Ultimately, I broke down my builds into 5 distinct stages:

**Setup:**
download app dependencies in a virtual environment and server setup. This step required creating a simple ansible playbook, to be triggered by Jenkins. The ansible playbook is in a file called build.yaml in my project’s root.

**Checkout:**
Checkout the project from git within the Jenkins workspace.

**Build:**
Run the actual project in the virtual environment. This step is testing the app’s basic execution.

**Test:**
This step involved running all of my functional tests, ensuring that no changes are impacting the functionality of each route within the app.

**Deploy:**
Checkout the most recent updates on the app’s root directory/server (separate server from Jenkins).

Given that this was my first Jenkins project, it was a relatively slow and iterative process getting everything to function as I wanted (took about 170 builds to get right!). Once I eventually had a working and complete Jenkinsfile, I found that Jenkins was repeatedly hanging on the testing step.

I set about changing the default debugging settings by creating a _'logging.properties'_ file and passing the settings to Jenkins at runtime. To pass specific configurations to Jenkins at runtime, I set specific environment variables within the _'override.conf'_ file, which can be accessed using _‘systemctl edit jenkins’_ on Ubuntu-based servers. Adding the following line to that file enables the settings from the logging.properties file to take precedence (will vary depending on location of _'logging.properties'_ file):

```
Environment="JAVA_OPTS=-Djava.util.logging.config.file=/etc/systemd/system/jenkins.service.d/logging.properties"
```

After optimizing the logs and doing some research, I diagnosed the issue as a memory problem and set about tinkering with the JVM settings related to memory optimization and garbage collection. The following configurations (also in override.conf) fixed my issue, allowing the full pipeline to run without a hitch:

```
Environment="JAVA_OPTS=-Xmx1024m -Xms1024m"
Environment="JAVA_OPTS=-XX:+UseG1GC -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:+UseCompressedOops"
```

The first set of commands increased the starting and maximum JVM memory heap to 1gb, which otherwise defaults to 1/64th of the physical memory up to 1gb, which in this case amounted to a much smaller allocation. The second grouping of variables changes the garbage collection to G1, which optimizes GC pause times by dynamically running parallel threads leading to greater throughput. The ‘UseCompressedOops’ command shrinks an object’s pointer from 64bit to 32bit.

With these optimizations, I’ve been able to run my builds smoothly without a hitch. Jenkins is much more stable, ensuring that I get build feedback quickly and efficiently, enhancing my workflow significantly. As my project scales, I’d like to maybe experiment with implementing a controller-agent architecture to distribute the payload for each job amongst multiple agent machines.

Below is my current Jenkinsfile for the project:

```
pipeline {
    agent any

    stages {
        stage('Setup') {
            steps {
                ansiblePlaybook installation: 'Ansible', playbook: 'build.yaml'
            }

        }
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jpdesc/Oura-Tracker-App.git']]])
            }
        }
        stage('Build') {
            steps {
                git branch: 'main', url: 'https://github.com/jpdesc/Oura-Tracker-App.git'
                sh """
                . /venvs/jenkins/bin/activate
                cat /srv/jenkins/.env > .env
                python run.py
                """
            }
        }
        stage('Test') {
            steps {
                sh """
                . /venvs/jenkins/bin/activate
                cat /srv/jenkins/.env > .env
                pytest ouraapp/tests/functional/
                """
            }
        }
        stage('Deploy') {
            steps {
                ansiblePlaybook installation: 'Ansible', inventory: 'hosts', playbook: 'deploy.yaml'
            }
        }
    }
}
```
