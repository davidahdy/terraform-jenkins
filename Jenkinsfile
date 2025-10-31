pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/davidahdy/terraform-jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var-file=terraform.tfvars'
            }
        }

        stage('Terraform Apply') {
            when {
                expression { return params.APPLY == true }
            }
            steps {
                sh 'terraform apply -auto-approve -var-file=terraform.tfvars'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.DESTROY == true }
            }
            steps {
                sh 'terraform destroy -auto-approve -var-file=terraform.tfvars'
            }
        }
    }

    parameters {
        booleanParam(name: 'APPLY', defaultValue: false, description: 'Run terraform apply')
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Run terraform destroy')
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}

