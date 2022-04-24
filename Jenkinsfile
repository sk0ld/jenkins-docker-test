pipeline {
  

  agent{ docker {
       image 'sk0ld/dev-alpine-mvn:latest'
       args '-v /var/run/docker.sock:/var/run/docker.sock  -u root:root'
    }
  }
  
   environment {
        APP_DIR = "./app-src"
        APP_IMAGE = "sk0ld/custom-boxfuse:latest"
        
    }

  
  stages {
    
    
    stage('Test') {
      steps {
        sh '''
          mvn --version
          docker --version
          docker ps
        '''
      }
     
    }

    stage ('git'){
     steps {
       sh '''
       rm -rf $APP_DIR
       git clone https://github.com/sk0ld/clone-boxfuse.git $APP_DIR
       '''
     }
    }
    

    stage('App build'){
      steps {
        sh 'cd $APP_DIR && mvn package -DskipTest'
      }
    }
    stage('Image build'){
      steps {
        sh 'cd $APP_DIR && docker build -t $APP_IMAGE .'
      }
    }
    stage('Docker push'){
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push $APP_IMAGE'}
      }
    }
    stage('Image cleanup'){
      steps {
        sh 'docker rmi $APP_IMAGE'
      }
    }

   }
     
  }