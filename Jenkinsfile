node {
        stage('build') {
            checkout scm
            sh 'echo ENV RAILS_ENV ${JOB_NAME} >> Dockerfile'
        }

        stage('brakeman') {
          sh 'gem install brakeman --no-ri --no-rdoc && brakeman -o brakeman-output.json --no-progress --separate-models"
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
