
  

     
       
   pipeline {
    agent any

     stages { 
          stage('Checkout Code') {
          steps {
                  //Check out the code from the GitHub repository 
                 checkout scm   
             }
         }
         
         stage('Zip Code') {
             steps {
                 // Zip the code in the current directory
                 sh 'zip -r java_spring.zip .'
             }
         }

         stage('Upload to GCR') {
             steps {
                 // Use GCP credentials to upload the code to GCR
                 withCredentials([file(credentialsId: 'fa0277d0-1428-449d-987c-001e1aed3bb3', variable: 'GCP_CREDENTIALS')]) {
                     sh ' gsutil cp java_spring.zip gs://java_code/java_spring.zip' 
                    
                 }
             }
         }

        stage('ssh-agent-into the vm'){
            steps{ 
                sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
                    sh 'ssh -tt  -oStrictHostKeyChecking=no anantharamachandranb@34.93.234.231 pwd'
                    sh 'ssh -tt anantharamachandranb@34.93.234.231 gsutil cp gs://java_code/java_spring.zip ./'
                    sh 'ssh -tt anantharamachandranb@34.93.234.231 unzip -o java_spring.zip -d /home/anantharamachandranb/unzipped'
                    
                }
            }
        }

        stage('Build') {
            steps {
                sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
                    // Your build commands go here
                    sh 'ssh -tt anantharamachandranb@34.93.234.231 "cd /home/anantharamachandranb/unzipped && ./gradlew build"'
                   // sh 'ssh -tt anantharamachandranb@35.244.9.36 ./gradlew build'
                    sh 'ssh -tt anantharamachandranb@34.93.234.231 "cd /home/anantharamachandranb/unzipped &&zip -r archive.zip build && mv archive.zip /home/anantharamachandranb/spring_builds"'
                }
            }

        }

          stage('Build upload to bucket') {
              steps {
             sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
                 // Use GCP credentials to upload the code to GCR
                 withCredentials([file(credentialsId: 'fa0277d0-1428-449d-987c-001e1aed3bb3', variable: 'GCP_CREDENTIALS')]) {
                     sh 'ssh -tt anantharamachandranb@34.93.234.231 gsutil cp /home/anantharamachandranb/spring_builds/archive.zip gs://java_builds/archive.zip'
                     //sh ' gsutil cp build gs://java_builds/${BUILD_ID}' 
                    
                 }
             }
         }
     }

           stage('Deploying the build'){
            steps{ 
                sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
                    sh 'ssh -tt  -oStrictHostKeyChecking=no anantharamachandranb@34.93.234.231 pwd'
                    sh 'ssh -tt anantharamachandranb@34.93.234.231 gsutil cp -r gs://java_builds/archive.zip ./'
                   // sh 'ssh -tt anantharamachandranb@34.93.234.231 unzip -o archive.zip -d /var/www/html'
                    
                }
            }
        }

        

    
    //     stage('Download Latest Version') {
    //        environment {
    //     GOOGLE_CLOUD_BUCKET = 'java_builds'
    //     OBJECT_NAME = 'archive.zip'
    //     LOCAL_PATH = '/home/anantharamachandranb'
    // }
    //         steps {
    //              sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
    //                script {
    //                 // Set the environment variable for the latest version number
    //                 def latestVersion = sh(script: "gsutil ls -la gs://${GOOGLE_CLOUD_BUCKET}/${OBJECT_NAME} | grep \"${OBJECT_NAME}\" | head -n 1 | awk '{print \$1}'", returnStdout: true).trim()

    //                 // Download the latest version
    //                 sh 'ssh -tt anantharamachandranb@34.93.234.231 gsutil cp gs://${GOOGLE_CLOUD_BUCKET}/${OBJECT_NAME}#${latestVersion} ${LOCAL_PATH}'
    //                }
    //             }
    //         }
    //     }
    

     
       
    }
}
