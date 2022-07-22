pipeline {
    
    agent any
    
stages {

stage('Build'){
   steps{
      bat "call Build.cmd"
    }
 }
    
stage('Publish'){
     steps{
       bat "call Publish.cmd"
     }
  }
 }
}
