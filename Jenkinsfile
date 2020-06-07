pipeline {
    agent {
        label 'Lable1'
    }
    parameters {
        choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the apache-server')
        string(name: 'workspace', description: "Name of the workspace")
    }
    stages {
        stage ('Cloning Script') {
            steps {
                checkout([$class: 'GitSCM', 				
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/kaza514/terr.git']]])
            }
        }
        stage('TF Plan') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                        sh """
                        terraform init
                        terraform workspace new ${params.workspace} || true
                        terraform workspace select ${params.workspace}
                        terraform plan
                        """
                    }
                }
        }
        stage('TF Apply') {
          when {
            expression { params.action == 'create' }
          }
          steps {
            script {
                        sh """ 
                        terraform apply -input=false -auto-approve
                        """
                    }
                }
        }
        stage('TF Destroy') {
          when {
            expression { params.action == 'destroy' }
          }
          steps {
            script {
                        sh """ 
                        terraform workspace select ${params.workspace}
                        terraform destroy -auto-approve
                        """
                    }
                }
        }
    }        
}
