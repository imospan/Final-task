This is a repository for the final project of EPAM Cloud&Devops Essentials course
=============
Brief overview:
---------------------------------------
- In this project I am deploying a PHP application on [AWS EC2 instances](https://aws.amazon.com/ec2/).
- Infrastracture is provisioned by [Terraform](https://www.terraform.io/).
- CI/CD process is managed with [Jenkins](https://www.jenkins.io/).
- It is installed on a Jenkins-server-node in a [Docker container](https://www.docker.com/) by a boot script.
- Two Web-server nodes are configured by [Ansible playbook](https://www.ansible.com/).
- Added a [webhook trigger](https://plugins.jenkins.io/generic-webhook-trigger/) for the Jenkins pipeline.
- Created two branches in the repository - `feature` and `main`.
- Created a [telegram bot](https://plugins.jenkins.io/telegram-notifications/) to notify about completed jobs.
- If the build form the main branch is succesfull, Jenkins uploads the project to [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/).
________________________

Below I'll describe deployment process step by step.

AWS infrastructure with Terraform
--------------------------
Via AWS Console create a new IAM user and add the `AdministratorAccess` Managed Policy to your IAM user. After user is created save *Access Key ID* and a *Secret Access Key*, these credentials give access to your AWS account.

For Terraform to be able to make changes in your AWS account, you will need to set the AWS credentials for the IAM user you created above as the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. For example, here is how you can do it in a Unix/Linux/macOS terminal:

```
$ export AWS_ACCESS_KEY_ID=(your access key id)
$ export AWS_SECRET_ACCESS_KEY=(your secret access key)
```
To deploy infrastructure execute the following commands in the root directory:
```
terraform init
terraform apply
```
After a while, we can check that instances are running via the AWS console:
![Знімок екрана_20230215_120037](https://user-images.githubusercontent.com/106439773/218996387-ca32e155-31c4-4437-aa86-f081838b7e64.png)\
All instances are deployed with Ubuntu 20.04, auto-generated SSH-key, Security group with opened needed ports, public IP, tags etc.
Pay attention to the `Outputs` and you will see the IP of your instances and ssh connection string to *Jenkins_server* via VS Code terminal like on the example below:\
![Знімок екрана_20230215_115956](https://user-images.githubusercontent.com/106439773/218996505-35e5c401-afed-4484-84a3-4a41d84c2135.png)

Attached [boot script](https://github.com/imospan/Final-task/blob/main/docker_jenkins.sh) installs Jenkins in a Docker container. Dockerfile, plugins list and CasC-file are taken by script from [config](https://github.com/imospan/Final-task/tree/main/config) folder. Jenkins user is `admin` while password is randomly generated and can be seen by accesing its EC2 instance and typing command `cat pass.txt`.

*Note: alternatively, you can install Jenkins directly to host OS (without Docker) by a [bash script](https://github.com/imospan/Final-task/blob/main/jenkins_install.sh).*

Ansible configuration management
-------------------------------
I used Ansible for installing and configuring Apache2 web-server onto my nodes. My boot script also installs Ansible and fetches pre-cofigured [playbook and roles](https://github.com/imospan/Final-task/tree/main/ansible) from this repository to *Jenkins-server* EC2 and unzips them. You'll need only to upload your private key to `.ssh` folder, make it read-only using `chmod 400` on it and update nodes' IPs in `inventory.txt`. You can check the connection with `ansible all -m ping` command. After updating config, use these commands to play Ansible:
```
cd ansible
ansible-playbook playbook.yml
```
The result of my playbook can be seen on a screen:\
![Знімок екрана_20230215_125514](https://user-images.githubusercontent.com/106439773/219008613-5104e58b-40fc-4f81-af63-7970b23b8ad0.png)

*Note: alternatively, you can install Apache2 by a simple [bash script](https://github.com/imospan/Final-task/blob/feature/terraform/modules/aws/apache.sh).*

Jenkins CI/CD management
------------------------------
<img align="left" src="https://user-images.githubusercontent.com/106439773/219455834-18037715-e568-4ec1-80e4-1ad6c6438f0b.png"></img>
I've configured a Multibranch pipeline with a webhook trigger from Github. The pipeline itself is described in Declarative syntax in [Jenkinsfile](https://github.com/imospan/Final-task/blob/main/Jenkinsfile), uploaded to this repository. It consists of three stages - Build, Test, Deploy and post-build notification. The deployment is carried out on a specific web-server for each branch. After that, the message is sent to the Telegram chat with name of the branch, links to the repository and the Jenkins console output. If the build from `main` branch was successful, we can trigger a job to deploy our application to AWS Elastic Beanstalk with just a single click from this message :sunglasses:
\
\
\
\
\
\
\
\
Here are some highlights for this setup.
First of all, manage your credentials with Jenkins:
![Знімок екрана_20230218_183354](https://user-images.githubusercontent.com/106439773/219955423-a4051e39-25f5-4ee2-9b56-33ef9ba80b0a.png)

Then create an environment for AWS Elastic Beanstalk:
![Знімок екрана_20230218_225147](https://user-images.githubusercontent.com/106439773/219955204-0045c349-c821-47d2-afa4-c56d9798621e.png)

And don't forget to attach permissions policies to your `jenkins` user in *AWS IAM* console:
![Знімок екрана_20230219_164042](https://user-images.githubusercontent.com/106439773/219955463-c158e328-91ae-4d1b-9d91-90c2248f6a89.png)

Create a multibranch pipeline in Jenkins and configure it to scan Jenkinsfile and the project itself from your reporistory. Then, add a webhook in Settings menu of your Github repository:
![Знімок екрана_20230219_161033](https://user-images.githubusercontent.com/106439773/219958547-ed7a42ca-3d04-4adb-8e7b-26d47f908b93.png)

After that, your pipeline should automatically download the Jenkinsfile and configure branches and stages from it:
![Знімок екрана_20230218_163653](https://user-images.githubusercontent.com/106439773/219958706-3d130e10-a23b-4690-a93a-1141961a774f.png)

That's how my pipeline looks after a few test runs with intentional errors:
![Знімок екрана_20230218_103251](https://user-images.githubusercontent.com/106439773/219959345-97c5a4e6-bd2a-4b17-b796-33447ce97c1d.png)

Screens with build notifications via Telegram. Build status is clickable and leads to the Jenkins console output.\
![Знімок екрана_20230218_102520](https://user-images.githubusercontent.com/106439773/219961014-4a011841-9138-4029-8ecd-32d4696db2a6.png)
![Знімок екрана_20230219_121935](https://user-images.githubusercontent.com/106439773/219961024-e07fbbef-3a02-44ef-a7f3-d5919d814475.png)

As I have mentioned before, if you click on *Deploy to AWS Beanstalk* it will trigger a corresponding Jenkins job. The result will look like this:
![Знімок екрана_20230219_121910](https://user-images.githubusercontent.com/106439773/219959778-fa4ff9ce-ca2f-40b5-8938-af26f592f28e.png)



