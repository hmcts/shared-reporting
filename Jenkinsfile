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
                sh "docker stop mssql"
                sh "docker rm mssql"
                sh "docker pull microsoft/mssql-tools"
                sh "docker run --name mssql -v ${WORKSPACE}:/root microsoft/mssql-tools /opt/mssql-tools/bin/sqlcmd -U '${USERNAME}' -P '${PASSWORD}'  -i /root/sql/query.sql"
        }
    }
}
