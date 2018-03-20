#!groovy

pipeline {
    agent {
        docker {
            image 'microsoft/mssql-tools'
            args '-v ./sql:/root/'
        }
    }
    stages {
        stage('Run Query') {
            steps {
                sh 'sqlcmd -U user -L password  -i /root/query.sql'
            }
        }
    }
}
