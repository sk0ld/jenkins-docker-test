pipeline {
  

  agent{ docker {
       image 'sk0ld/dev-alpine-mvn:latest'
       args '-v /var/run/docker.sock:/var/run/docker.sock  -u root:root'
    }
  }

  
  stages {
    
stage('start cleanup') {
    steps { 
    cleanWs deleteDirs: true, disableDeferredWipeout: false}
   }
    

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
       sh 'rm -rf ./app-src'
       sh 'git clone https://github.com/sk0ld/clone-boxfuse.git ./app-src'
     }
    }
    

    stage('App build'){
      steps {
        sh 'cd ./app-src && mvn package -DskipTest'
      }
    }
    stage('Image build'){
      steps {
        sh 'cd ./app-src && docker build -t sk0ld/custom-boxfuse:latest .'
      }
    }
    stage('Docker push'){
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push sk0ld/custom-boxfuse:latest'}
      }
    }
   stage('finish cleanup') {
     steps { 
    cleanWs deleteDirs: true, disableDeferredWipeout: false}
   }
     
  }
  }
