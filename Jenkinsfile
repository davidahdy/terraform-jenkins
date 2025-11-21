pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"     // Change to your region
        TF_WORKDIR = "./"            // Terraform working directory
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],   // Change branch if needed
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
            steps {
                dir("${TF_WORKDIR}") {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Do you want to apply the Terraform plan?'
                dir("${TF_WORKDIR}") {
                  //  sh 'terraform apply -auto-approve tfplan'
                    sh 'terraform destroy -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo "✅ EKS cluster deployed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
