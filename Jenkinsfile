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
        stage('feature') {
            when {
                anyOf {
                    branch "feature"
                }
            }
            
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'Feature_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/', remoteDirectorySDF: false, removePrefix: '/my_project/', sourceFiles: '/my_project/**.**')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('main website') {
            when {
                anyOf {
                    branch "main"
                }
            }
            steps {
                echo 'Jenkins makes a main build'
            }
        }
    }
    post {
         success { 
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Branch*: [$GIT_BRANCH]($GIT_URL) \n *Build* : [OK](${BUILD_URL}consoleFull)'
            """)
         }

         aborted {
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Branch*: [$GIT_BRANCH]($GIT_URL) \n *Build* : [Aborted](${BUILD_URL}consoleFull)'
            """)
         }
         failure {
            sh  ("""
                curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*https://github.com/imospan/Final-task* \n *Branch*: [$GIT_BRANCH]($GIT_URL) \n *Build* : [Not OK](${BUILD_URL}consoleFull)'
            """)
         }

    }
}
