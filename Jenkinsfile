@Library('Infrastructure') _

node {
    triggers {
        cron('30 08 * * *')
    }
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
            -f /root/sql/query.sql -L /root/result -q -d postgres -p 5432 -U ${USERNAME} -h ccd-data-store-api-data-store-aat-midb.postgres.database.azure.com"""
        }
    }
    stage('Cleanup') {
        sh "docker stop pgclient"
        sh "docker rm pgclient"
    }
}
