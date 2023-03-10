#!/usr/bin/env groovy
pipeline {
    agent any
    options {
      buildDiscarder(logRotator(numToKeepStr: '5')) 
      timestamps()
    }
    
    environment {
        TOKEN = credentials("BOT_TOKEN")
        CHAT_ID = credentials("CHAT_ID")     
    }    
    
    stages {
        stage('Build') {
            steps {
              echo "<---------- Build started ---------->"
              echo "Build $BUILD_NUMBER"
              echo "<----------- Build ended ----------->"
            }
        }    
        stage('Test') {
            steps {
              echo "<----------- Test started ----------->"
              sh '''
              cd my_project
              result=`grep "Ivan" index.php | wc -l`
              echo $result
              if [ "$result" = "1" ]
              then
                  echo "Test passed"
              else
                  echo "Test failed"
                  exit 1
              fi
              '''
              echo "<------------ Test ended ------------>"
            }
        }
        stage('Deploy to Main') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'Main-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/', remoteDirectorySDF: false, removePrefix: '/my_project/', sourceFiles: 'my_project/')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }    
    }    
    post {
         success { 
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Job Name: My PHP application* \n *Branch*: $GIT_BRANCH \n *Build* : [Success](${BUILD_URL}consoleFull) \n \n [Deploy to AWS Beanstalk](http://3.85.175.28:8080/job/Deploy-AWS-Beanstalk-Job/build?token=beanstalktoken)'
            """)
         }

         aborted {
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Job Name: My PHP application* \n *Branch*: $GIT_BRANCH \n *Build* : [Aborted](${BUILD_URL}consoleFull)'
            """)
         }
         failure {
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Job Name: My PHP application* \n *Branch*: $GIT_BRANCH \n *Build* : [Failure](${BUILD_URL}consoleFull)'
            """)
         }
    }
}
