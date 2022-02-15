#!/bin/groovy

pipeline {
	agent any

	environment {
		// API_KEY stored as a credential in Jenkins
        	WH_API_KEY = credentials('wh-main-api-key')
		// Docker hub registry
		IMG_REPO = "mmebin/wh"
	}

	stages {
		stage ('Clone repository'){
			steps {
			  // asuming git is configured in Jenkins job	
		          checkout scm
			}
		}
		stage ('Build, Scan and Push') {
			steps {
			  script {
			   def appImage = docker.build("${env.IMG_REPO}:${env.BUILD_ID}")
			   env.APP_IMG = appImage.imageName()

			   // scanning new images for any vulnerabilities before pushing to registry
			   sh('trivy image --no-progress --ignore-unfixed --exit-code 1 --severity HIGH,CRITICAL ${APP_IMG}')
			   
			   docker.withRegistry('', 'docker-hub-creds') {
				appImage.push()
			    }
			  }
			}
		}
		stage ('Deploy') {
			steps {
			// Creating secret from wh-main-api-key
			 sh('kubectl create secret generic wh-main-secrets --from-literal=API_KEY=${WH_API_KEY} --dry-run=client -oyaml > manifest/secret.yaml')
			 // Replacing image tag
		         sh """
			    yq -i '.spec.template.spec.containers[].image = \"${APP_IMG}\"' manifest/deployment.yaml
			    kubectl apply -f manifest/
			  """
			}
		}
	}
}
