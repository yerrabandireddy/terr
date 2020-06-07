pipeline {
    agent {
        label 'Lable1'
    }
    parameters {
        choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the apache-server')
        string(name: 'workspace', defaultValue : 'apache-server', description: "Name of the workspace")
    }
    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/kaza514/helloworld.git'
            }
        }
        stage('Setup') {
            steps {
                script {
                    currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + " apache-server"
                    plan = params.workspace + '.plan'
                }
            }
        }
        stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform -version'
            }
        }
        stage('TF Plan') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    dir('terraform_apacheSrever') {
                        sh """
                        terraform init
                        terraform workspace new ${params.workspace} || true
                        terraform workspace select ${params.workspace}
                        terraform plan \
                        -out ${plan}
                        """
                        }
                    }
                }
            }
        }
        stage('TF Apply') {
          when {
            expression { params.action == 'create' }
          }
          steps {
            script {
                    dir('terraform_apacheSrever') {
                        sh """ 
                        terraform apply -input=false -auto-approve ${plan}
                        """
                        }
                    }
                }
            }
        }
        stage('TF Destroy') {
          when {
            expression { params.action == 'destroy' }
          }
          steps {
            script {
                    dir('terraform_apacheSrever') {
                        sh """ 
                        terraform workspace select ${params.workspace}
                        terraform destroy -auto-approve
                        """
                        }
                    }
                }
            }
	    }
    }
}

