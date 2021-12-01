//def credentialsForTestWrapper(block) {
    // it's a module repo, we only use dev credentials for developing and testing
    // once code has been merged to master, use dev credentials to finish the unit testing
    //withCredentials([
    //    [
    //        $class: 'ConjurSecretApplianceCredentialsBinding',
    //        credentialsId: "cpiactoolchain",
    //        sPath: "projects/iactcprd/prod/variables/TERRA_EXAMPLE_AK",
    //        // variable: 'TERRA_EXAMPLE_AK'
    //        variable: 'AWS_ACCESS_KEY_ID'
    //    ],
    //    [
    //        $class: 'ConjurSecretApplianceCredentialsBinding',
    //        credentialsId: "cpiactoolchain",
    //        sPath: "projects/iactcprd/prod/variables/TERRA_EXAMPLE_SK",
    //        // variable: 'TERRA_EXAMPLE_SK'
    //        variable: 'AWS_SECRET_ACCESS_KEY'
    //    ],
    //]) {
    //    block.call()
    //}
//}

String credentialsId = 'aws_test'


def credentialsForTestWrapper(block) {

    String credentialsId = 'aws_test'
    
    withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
    ]]) 
}


def TEST_DIR='./tests'

pipeline{
    agent any

    options {
        ansiColor('xterm')
        lock resource: 'terraform_landing_network'
    }

    stages {
        stage("Validate Terraform resources") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    /opt/terraform/terraform init
                    /opt/terraform/terraform validate
                    /opt/terraform/terraform plan
                    """
                }
              }
            }
        }

        stage("Apply Terraform resources on Cloud") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh "/opt/terraform/terraform apply -auto-approve -parallelism=2"
                }
              }
            }
        }

        stage("Run unit test") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    rm -f ./inspec/inspec.lock
                    rm -f ./inspec/files/terraform_output.json
                    terraform output --json > ./inspec/files/terraform_output.json
                    inspec exec inspec -t aws:// --chef-license accept-silent --reporter cli junit:./inspec/reports/junits_out.xml
                    """
                }
              }
            }
        }
    }

    post {
        always {
          dir (TEST_DIR) {
           credentialsForTestWrapper {
              sh "/opt/terraform/terraform destroy -auto-approve -parallelism=2"
           }
             junit allowEmptyResults: true, testResults: './inspec/reports/junits_out.xml'
          }
        }
        cleanup {
            cleanWs()
        }
    }
}