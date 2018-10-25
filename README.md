Feature Branch Testing

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "hello_world" {
  filename         = "function.zip"
  function_name    = "terraform-poc-arlo"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("function.zip"))}"
  runtime          = "nodejs8.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}


pipeline {
    agent {
        node {
            label 'master'
        }
    }

    stages {

        stage('terraform started') {
            steps {
                sh 'echo "Started...!" '
            }
        }
        stage('git clone') {
            steps {
                sh 'sudo rm -r *;sudo git clone https://github.com/aleti-pavan/jenkins.git'
            }
        }
        stage('tfsvars create'){
            steps {
                sh 'sudo cp /home/ec2-user/vars.tf ./jenkins/'
            }
        }
        stage('terraform init') {
            steps {
                sh 'sudo /home/ec2-user/terraform init ./jenkins'
            }
        }
        stage('terraform plan') {
            steps {
                sh 'ls ./jenkins; sudo /home/ec2-user/terraform plan -target=resource.hello-world -var-file hello-world-poc.tfvars  -out hello-world-poc.tfplan ./jenkins'
            }
        }
		stage('terraform apply') {
            steps {
                sh 'sudo /home/ec2-user/terraform apply hello-world-poc.tfplan ./jenkins'
            }
        }
        stage('terraform ended') {
            steps {
                sh 'echo "Ended....!!"'
            }
        }

        
    }
}
