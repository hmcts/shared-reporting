@Library('Infrastructure') _

properties([pipelineTriggers([cron('H 02 * * *')])])

node {
    stage('Checkout') {
      deleteDir()
      checkout scm
    }
    stage('Run Query') {    
        def DIVORCE_METRICS_QUERY = /SELECT * from case_data limit 2;/
        def DB_HOST = /ccd-data-store-api-postgres-db-prod.postgres.database.azure.com/

        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'shared-reporting-credentials',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                docker.image('jbergknoff/postgresql-client').inside("--entrypoint='' -e PGPASSWORD=${PASSWORD} -v ${WORKSPACE}:/root") { 
                    sh "psql -f /root/sql/query.sql -o /root/report1.csv -q -d postgres -p 5432 -U ${USERNAME} -h ${DB_HOST}"
                    sh "psql -f /root/sql/get_divorce_metrics.sql -q -d postgres -p 5432 -U ${USERNAME} -h ${DB_HOST}"
                    sh "psql -p 5432 -U ${USERNAME} -h ${DB_HOST} -d postgres -q -A -F',' -c '${DIVORCE_METRICS_QUERY}' > /root/divorce.csv "
                }
        }
    }
    stage('Email Report') {
        sh "echo 'Please find the report attached.'| mail -s 'Divorce Shared Reporting Output' -a '${WORKSPACE}/divorce.csv' -r 'noreply@reform.hmcts.net (Shared Reporting)' Alliu.Balogun@HMCTS.NET James.Johnson@HMCTS.NET" 
        //sh "echo 'Please find the report attached.'| mail -s 'Shared Reporting Output' -a '${WORKSPACE}/report2.csv' -r 'noreply@reform.hmcts.net (Shared Reporting)' Alliu.Balogun@HMCTS.NET James.Johnson@HMCTS.NET"  
    }
}
