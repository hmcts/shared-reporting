@Library('Infrastructure') _

node {
    stage('Checkout') {
      deleteDir()
      checkout scm
    }
    stage('Setup') {
        sh "docker pull jbergknoff/postgresql-client"
    }
    stage('Run Query') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'shared-reporting-credentials',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sh """docker run --name pgclient -e PGPASSWORD=${PASSWORD} -v ${WORKSPACE}:/root jbergknoff/postgresql-client \
            -f /root/sql/query.sql -o /root/report.csv -q -d postgres -p 5432 -U ${USERNAME} -h ccd-data-store-api-data-store-aat-restore.postgres.database.azure.com"""
        }
    }
    stage('Email Report') {
        sh "echo 'Please find the report attached.'| mail -s 'Shared Reporting Output' -a '${WORKSPACE}/report.txt' -r 'noreply@reform.hmcts.net (Shared Reporting)' Alliu.Balogun@HMCTS.NET James.Johnson@HMCTS.NET cftprogrammepmo@hmcts.gsi.gov.uk"       
    }
    stage('Cleanup') {
        sh "docker stop pgclient"
        sh "docker rm pgclient"
    }
}
