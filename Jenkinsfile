#!groovy

pipeline {
    agent any
    stages {
        stage('Run Query') {
            steps {
                sh "docker pull microsoft/mssql-tools"
                sh "docker run microsoft/mssql-tools --name mssql"
                sh "docker exec -i mssql /opt/mssql-tools/bin/sqlcmd -U user -L password  -i /root/query.sql"
                sh "docker stop mssql"
            }
        }
    }
}
