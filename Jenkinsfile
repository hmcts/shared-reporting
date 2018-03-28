@Library('Infrastructure') _

node {
    stage('Checkout') {
      deleteDir()
      checkout scm
    }
    stage('GetUserCredential') {
        // Requires Credential setup (MyCredentialID)
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'shared-reporting-credentials',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                sh "docker stop psql-client"
                sh "docker rm psql-client"
                sh "docker pull jbergknoff/postgresql-client"
                sh "docker run --name psql-client -v ${WORKSPACE}:/root jbergknoff/postgresql-client -e PGPASSWORD=${PASSWORD} psql -U '${USERNAME}' -h ccd-data-store-api-data-store-aat-midb.postgres.database.azure.com -p 5432  -f /root/sql/query.sql -L /root/result "
                sh "docker stop psql-client"
                sh "docker rm psql-client"
        }
    }
}
