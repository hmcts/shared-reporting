#!groovy

pipeline {
    agent any
    stages {
        stage('Run Query') {
            steps {
                step('Get MS SQL Tools Image) {
                    sh "docker pull microsoft/mssql-tools"
                },
                step('Run MS SQL Tools Container) {
                    sh "docker run microsoft/mssql-tools --name mssql"
                },
                step('Execute Query) {
                    sh "docker exec -i mssql /opt/mssql-tools/bin/sqlcmd -U user -L password  -i /root/query.sql"
                },
                step('Stop MS SQL Tools Container) {
                    sh "docker stop mssql"
                } 
            }
        }
    }
}
