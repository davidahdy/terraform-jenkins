pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Choose whether to apply or destroy the Terraform infrastructure.'
        )
    }

    environment {
        AWS_REGION = "us-east-1"
        TF_WORKDIR = "./"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/davidahdy/terraform-jenkins.git']]
                ])
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_WORKDIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir("${TF_WORKDIR}") {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                input message: 'Apply the Terraform plan?'
                dir("${TF_WORKDIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input message: 'Destroy all Terraform resources?'
                dir("${TF_WORKDIR}") {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Terraform ${params.ACTION} completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed during Terraform ${params.ACTION}."
        }
    }
}
