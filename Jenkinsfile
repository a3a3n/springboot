pipeline {
    agent any

     stages { 
    //     stage('Checkout Code') {
    //         steps {
    //             // Check out the code from the GitHub repository 
    //             checkout scm   
    //         }
    //     }
        
    //     stage('Zip Code') {
    //         steps {
    //             // Zip the code in the current directory
    //             sh 'zip -r java_spring.zip .'
    //         }
    //     }

    //     stage('Upload to GCR') {
    //         steps {
    //             // Use GCP credentials to upload the code to GCR
    //             withCredentials([file(credentialsId: 'fa0277d0-1428-449d-987c-001e1aed3bb3', variable: 'GCP_CREDENTIALS')]) {
    //                 sh ' gsutil cp java_spring.zip gs://java_code/java_spring.zip' 
                    
    //             }
    //         }
    //     }

            
            // stage('SSH INTO THE VM') {
            // steps {
          
            //       script {
            //             sh '''
            //                   #gcloud compute ssh instance-1 --zone=asia-south1-a
            //                   # ssh -i /home/anantharamachandranb/.ssh/new_key anantharamachandranb@34.100.238.195  
            //             '''
            //         }
            //     }
            // }

        stage('ssh-agent-into the vm'){
            steps{
                sshagent(['eed58fa2-36d4-49f6-86f3-ef8b57bbb9be']) {
                    sh 'ssh -tt anantharamachandranb@35.244.9.36 gsutil cp gs://java_code/java_spring.zip/'
                   // sh 'ssh -tt anantharamachandranb@34.100.238.195 gsutil cp gs://java_code/java_spring.zip/'
                    //sh 'ssh -tt anantharamachandranb@34.100.238.195 unzip java_spring.zip -d /var/www/html/my-spring-boot-app'
                    
                }
            }
        }

    
        // stage('Interactive SSH Session') {
        //     steps {
        //         script {
        //             // Replace with your SSH command
        //             def sshCommand = 'ssh -v -i /home/anantharamachandranb/.ssh/new_key anantharamachandranb@34.100.238.195'
        //             def sshCommandd = 'ssh -i /home/anantharamachandranb/.ssh/new_key -o StrictHostKeyChecking=no anantharamachandranb@34.100.238.195'

        //             // Start an SSH session
        //             sh(script: sshCommandd, returnStatus: true)

        //             // You can run additional commands in the remote shell session
        //             sh(script: 'ls -l', returnStatus: true)

        //             // Close the SSH session
        //             sh(script: 'exit', returnStatus: true)
        //         }
        //     }
        // }
    


     
        // stage('Deploy to VM') {
        //     steps {
          
        //             script {
        //                 sh '''
                          
        //                     # Download and unzip the code from GCR
                             
        //                       #gsutil cp gs://jenkins_1/moodle_app.zip ./
        //                       pwd
                            
        //                     # Implement custom logic to replace changed files
        //                     # This is a placeholder for your custom logic
        //                     # You can compare and replace only changed files here
        //                 '''
        //             }
                
        //     }
        // }
    }
}
