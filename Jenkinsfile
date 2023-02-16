pipeline {
    agent any

    stages {
        stage('Deploy PHP to Feature') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'Feature-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/', remoteDirectorySDF: false, removePrefix: '/my_project/', sourceFiles: 'my_project/')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
