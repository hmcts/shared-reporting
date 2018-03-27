#!groovy

pipeline {
    stages {
        stage('Run Query') {
            steps {
                sh "docker pull microsoft/mssql-tools"
                sh "docker run -it microsoft/mssql-tools --name mssql"
                sh "docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -U user -L password  -i /root/query.sql" 
            }
        }
    }
}
