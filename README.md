This is a repository for the final project of EPAM Cloud&Devops Essentials course
=============
Brief overview:
---------------------------------------
- In this project I am deploying a PHP application on [AWS EC2 instances](https://aws.amazon.com/ec2/).
- Infrastracture is provisioned by [Terraform](https://www.terraform.io/).
- CI/CD process is managed with [Jenkins](https://www.jenkins.io/).
- It is installed on a Jenkins-server-node in a [Docker container](https://www.docker.com/) by a boot script.
- Two Web-server nodes are configured by [Ansible playbook](https://www.ansible.com/).
- Added a webhook trigger for the Jenkins pipeline.
- Created two branches in the repository.
- Created a telegram bot to notify about completed jobs.
- If the build form the main branch is succesfull, Jenkins uploads the project to [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/).
________________________
To do:\
screens\
telegram notification\
elastic beanstalk auto-deployment

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

My script also installs Ansible and fetches pre-cofigured [playbook and roles](https://github.com/imospan/Final-task/tree/main/ansible) from this repository and unzips them. You need only to upload your private key to `.ssh` folder, use `chmod 400` on it and update nodes' IP in `inventory.txt`. You can check the connection with `ansible all -m ping` command. After updating config, use these commands to play Ansible:
```
cd ansible
ansible-playbook playbook.yml
```
The result of my playbook can be seen on a screen:\
![Знімок екрана_20230215_125514](https://user-images.githubusercontent.com/106439773/219008613-5104e58b-40fc-4f81-af63-7970b23b8ad0.png)







