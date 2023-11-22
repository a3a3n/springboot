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
                    sh 'ssh -tt  -oStrictHostKeyChecking=no anantharamachandranb@35.244.9.36 pwd'
                    sh 'ssh -tt anantharamachandranb@35.244.9.36 gsutil cp gs://java_code/java_spring.zip ./'
                    sh 'ssh -tt anantharamachandranb@35.244.9.36 unzip java_spring.zip -d /var/www/html/my-spring-boot-app'
                    
                }
            }
        }
  
    


     
       
    }
}
