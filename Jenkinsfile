node {
        stage('build') {
            checkout scm
            sh 'echo ENV RAILS_ENV ${JOB_NAME} >> Dockerfile'
        }


        stage('dockerization') {

          def app = docker.build("wolf685cln/${JOB_NAME}")
          docker.withRegistry('https://registry.hub.docker.com','docker-login') {
              app.push 'latest'
          }
        }

        stage('cleanup') {
          step([$class: 'WsCleanup'])
        }
}
