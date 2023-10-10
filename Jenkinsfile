pipeline {  
    environment {
      branchname =  env.BRANCH_NAME.toLowerCase()
    }

   agent { kubernetes { 
              label 'flutter3106'
              defaultContainer 'flutter3106'
            }
          }
    
    options {
      buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
      disableConcurrentBuilds()
      skipDefaultCheckout()  
    }

    stages {
       stage('CheckOut') {
        steps {
          checkout scm
          script {
            sh("pwd")
            sh("ls -ltra")
            APP_VERSION = sh(returnStdout: true, script: "cat pubspec.yaml | grep version: | awk '{print \$2}'") .trim()
            sh("echo ${APP_VERSION}")
            sh("echo ${BUILD_NUMBER}")
            }
        }
      }
      
      stage('Build APK Dev') {
        when { 
          anyOf { 
            branch 'develop'; 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'plateia-app-google-service-dev', variable: 'GOOGLEJSONDEV'),
            file(credentialsId: 'plateia-app_key-properties', variable: 'APPKEYPROPERTIES'),
            file(credentialsId: 'plateia-app_firebase_options_development', variable: 'FIREBASEDEV'),
            file(credentialsId: 'plateia-app_upload-keystore-jks', variable: 'APPKEYUPLOAD'),
            file(credentialsId: "plateia-app_env_${branchname}", variable: 'env'),
    ]) {
            sh 'cd ${WORKSPACE}'
            sh 'cp ${GOOGLEJSONDEV} android/app/src/development/google-services.json'
            sh 'mkdir -p lib/app/firebase'
            sh 'cp ${FIREBASEDEV} lib/app/firebase/firebase_options_development.dart '
            sh 'cp ${APPKEYPROPERTIES} android/key.properties'
            sh 'cp ${APPKEYUPLOAD} android/app/upload-keystore.jks'
            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            sh 'cp ${env} .env'
            sh 'flutter clean'
            sh 'flutter pub get'
            sh 'flutter packages pub run build_runner build --delete-conflicting-outputs'
            sh "flutter build apk --build-name=${APP_VERSION} --build-number=${BUILD_NUMBER} --release --flavor=development --target lib/main_development.dart --no-tree-shake-icons"
            sh "ls -ltra build/app/outputs/flutter-apk/"
            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            stash includes: 'build/app/outputs/flutter-apk/**/*.apk', name: 'appbuild'
          }
        }
      }

      stage('Build APK Hom') {
        when { 
          anyOf { 
            branch 'release' 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'plateia-app-google-service-hom', variable: 'GOOGLEJSONHOM'),
            file(credentialsId: 'plateia-app_key-properties', variable: 'APPKEYPROPERTIES'),
            file(credentialsId: 'plateia-app_firebase_options_staging', variable: 'FIREBASEHOM'),
            file(credentialsId: 'plateia-app_upload-keystore-jks', variable: 'APPKEYUPLOAD'),
            file(credentialsId: "plateia-app_env_${branchname}", variable: 'env'),
    ]) {
            sh 'cd ${WORKSPACE}'
            sh 'cp ${GOOGLEJSONHOM} android/app/src/staging/google-services.json'
            sh 'mkdir -p lib/app/firebase'
            sh 'cp ${FIREBASEHOM} lib/app/firebase/firebase_options_staging.dart '
            sh 'cp ${APPKEYPROPERTIES} android/key.properties'
            sh 'cp ${APPKEYUPLOAD} android/app/upload-keystore.jks'
            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            sh 'cp ${env} .env'
            sh 'flutter clean'
            sh 'flutter pub get'
            sh 'flutter packages pub run build_runner build --delete-conflicting-outputs'
            sh "flutter build apk --build-name=${APP_VERSION} --build-number=${BUILD_NUMBER} --release --flavor=staging --target lib/main_staging.dart --no-tree-shake-icons"
            sh "ls -ltra build/app/outputs/flutter-apk/"
            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            stash includes: 'build/app/outputs/flutter-apk/**/*.apk', name: 'appbuild'
          }
        }
      }
      
      stage('Build APK Prod') {
        when {
          branch 'master'
        }
        steps {
          withCredentials([
            file(credentialsId: 'plateia-app-google-service-prod', variable: 'GOOGLEJSONPROD'),
            file(credentialsId: 'plateia-app_key-properties', variable: 'APPKEYPROPERTIES'),
            file(credentialsId: 'plateia-app_firebase_options_production', variable: 'FIREBASEPROD'),
            file(credentialsId: 'plateia-app_upload-keystore-jks', variable: 'APPKEYUPLOAD'),
            file(credentialsId: "plateia-app_env_${branchname}", variable: 'env'),
    ]) {
            sh 'cd ${WORKSPACE}'
            sh 'cp ${GOOGLEJSONPROD} android/app/src/production/google-services.json'
            sh 'mkdir -p lib/app/firebase'
            sh 'cp ${FIREBASEPROD} lib/app/firebase/firebase_options_production.dart '
            sh 'cp ${APPKEYPROPERTIES} android/key.properties'
            sh 'cp ${APPKEYUPLOAD} android/app/upload-keystore.jks'
            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            sh 'cp ${env} .env'
            sh 'flutter clean'
            sh 'flutter pub get'
            sh 'flutter packages pub run build_runner build --delete-conflicting-outputs'
            
            sh "flutter build appbundle --build-name=${APP_VERSION} --build-number=${BUILD_NUMBER} --release --flavor=production --target lib/main_production.dart --no-tree-shake-icons"
            sh "flutter build apk --build-name=${APP_VERSION} --build-number=${BUILD_NUMBER} --release --flavor=production --target lib/main_production.dart --no-tree-shake-icons"

            sh "ls -ltra build/app/outputs/flutter-apk/"
            sh "ls -ltra build/app/outputs/bundle/productionRelease/"

            sh 'if [ -d ".env" ]; then rm -f .env; fi'
            stash includes: 'build/app/outputs/bundle/productionRelease/**/*.aab', name: 'appbuild'
            stash includes: 'build/app/outputs/flutter-apk/**/*.apk', name: 'appbuild'
          }
        }
      }

      stage('Tag Github Dev') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'develop'; }}
        steps{
          script{
            try {
              withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                sh("github-release release --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-dev --name app-${APP_VERSION}-dev")
              }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }

      stage('Tag Github Hom') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'release'; }}
        steps{
          script{
            try {
              withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                sh("github-release release --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-hom --name app-${APP_VERSION}-hom")
              }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }     

      stage('Tag Github Prod') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'master'; }}
        steps{
          script{
            try {
              withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                sh("github-release release --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-prod --name app-${APP_VERSION}-prod")
              }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }   

      stage('Release Github Dev') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'develop'; }}
        steps{
          script{
            try {
                withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                    sh ("rm -Rf tmp")
                    dir('tmp'){
                        unstash 'appbuild'
                    }
                    sh ("github-release upload --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-dev --name "+"app-${APP_VERSION}-dev.apk"+" --file tmp/build/app/outputs/flutter-apk/app-development-release.apk --replace")
                }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }  

      stage('Release Github Hom') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'release'; }}
        steps{
          script{
            try {
                withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                    sh ("rm -Rf tmp")
                    dir('tmp'){
                        unstash 'appbuild'
                    }
                    sh ("echo \"app-${env.branchname}.apk\"")
                    sh ("github-release upload --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-hom --name "+"app-${APP_VERSION}-hom.apk"+" --file tmp/build/app/outputs/flutter-apk/app-staging-release.apk --replace")
                }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }
      
      stage('Release Github Prod') {
        agent { kubernetes { 
              label 'builder'
              defaultContainer 'builder'
            }
          }
        when { anyOf {  branch 'master'; }}
        steps{
          script{
            try {
                withCredentials([string(credentialsId: "github_token_serap_app", variable: 'token')]) {
                    sh ("rm -Rf tmp")
                    dir('tmp'){
                        unstash 'appbuild'
                    }
                    sh ("echo \"app-${env.branchname}.apk\"")
                    sh ("github-release upload --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-prod --name "+"app-${APP_VERSION}-prod.apk"+" --file tmp/build/app/outputs/flutter-apk/app-production-release.apk --replace")
                    
                    sh ("echo \"app-${env.branchname}.aab\"")
                    sh ("github-release upload --security-token "+"$token"+" --user prefeiturasp --repo SME-Plateia-App --tag ${APP_VERSION}-prod --name "+"app-${APP_VERSION}-prod.aab"+" --file tmp/build/app/outputs/bundle/productionRelease/app-production-release.aab --replace")
                }
            } 
            catch (err) {
                echo err.getMessage()
            }
          }
        }   
      }  

  }

  post {
    always {
      echo 'One way or another, I have finished'
      script{
        if (env.BRANCH_NAME.toLowerCase() == 'develop' || env.BRANCH_NAME.toLowerCase() == 'release') {
          archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/**/*.apk', fingerprint: true
        } else if (env.BRANCH_NAME.toLowerCase() == 'master') {
          archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/**/*.apk', fingerprint: true
          archiveArtifacts artifacts: 'build/app/outputs/bundle/productionRelease/**/*.aab', fingerprint: true
        }
      }
    }
  }
}
