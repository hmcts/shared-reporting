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
            psql -U '${USERNAME}' -h ccd-data-store-api-data-store-aat-midb.postgres.database.azure.com -p 5432  -f /root/sql/query.sql -L /root/result"""
        }
    }
    stage('Cleanup') {
        sh "docker stop pgclient"
        sh "docker rm pgclient"
    }
}
