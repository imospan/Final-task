#!/usr/bin/env groovy
pipeline {
   agent any
   options {
      buildDiscarder(logRotator(numToKeepStr: '5')) 
      timestamps()
   }
    
   environment {
      OWNER = 'mosya'
   }
    
   stages {
   
      stage("Build") {
          steps {
            echo 'Jenkins makes a build'
         }
      }
      
      stage("Tests") {
          steps {
            echo 'Jenkins makes tests'
         }
      }

      stage('Notification') {
         when {
            branch 'main'
	   }
         steps {
            notifyEvents message: "Hello ${OWNER}, build and test were successful", token: 'wEdjJ5L4-hGIzg39oGxWt_qqz-AtHqIY'
            echo 'Jenkins sends notification to Telegram about successful job'
         }
      }  
   }
}
