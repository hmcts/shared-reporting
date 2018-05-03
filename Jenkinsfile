@Library('Infrastructure') _

properties([pipelineTriggers([cron('H 02 * * *')])])

node {
    stage('Checkout') {
      deleteDir()
      checkout scm
    }
    stage('Run Query') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'shared-reporting-credentials',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            
            docker.image('jbergknoff/postgresql-client').withRun("--name pgclient -e PGPASSWORD=${PASSWORD} -v ${WORKSPACE}:/root") { c ->
                docker.image('jbergknoff/postgresql-client').inside() { c -> 
                    sh "psql -f /root/sql/query.sql -o /root/report1.csv -q -d postgres -p 5432 -U ${USERNAME} -h ccd-data-store-api-data-store-aat-restore.postgres.database.azure.com"
                    sh "psql -f /root/sql/query.sql -o /root/report2.csv -q -d postgres -p 5432 -U ${USERNAME} -h ccd-data-store-api-data-store-aat-restore.postgres.database.azure.com"
                }
            }
        }
    }
    stage('Email Report') {
        sh "echo 'Please find the report attached.'| mail -s 'Shared Reporting Output' -a '${WORKSPACE}/report1.csv' -r 'noreply@reform.hmcts.net (Shared Reporting)' Alliu.Balogun@HMCTS.NET James.Johnson@HMCTS.NET" 
        sh "echo 'Please find the report attached.'| mail -s 'Shared Reporting Output' -a '${WORKSPACE}/report2.csv' -r 'noreply@reform.hmcts.net (Shared Reporting)' Alliu.Balogun@HMCTS.NET James.Johnson@HMCTS.NET"  
    }
    stage('Cleanup') {
        sh "docker stop pgclient"
        sh "docker rm pgclient"
    }
}
