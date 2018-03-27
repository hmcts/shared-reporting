#!groovy

pipeline {
    agent any
    stages {
        stage('Run Query') {
            steps {
                step('Get MS SQL Tools Image) {
                    sh "docker pull microsoft/mssql-tools"
                },
                step('Get MS SQL Tools Image) {
                    sh "docker run microsoft/mssql-tools --name mssql"
                }
                step('Get MS SQL Tools Image) {
                    sh "docker exec -i mssql /opt/mssql-tools/bin/sqlcmd -U user -L password  -i /root/query.sql"
                }
                step('Get MS SQL Tools Image) {
                    sh "docker stop mssql"
                } 
            }
        }
    }
}
