node {
        stage('build') {
            checkout scm
        }

        stage('dockerize') {

          def app = docker.build("wolf685cln/msi-directory-app")
          docker.withRegistry('https://registry.hub.docker.com','docker-login') {
              app.push 'latest'
          }
        }

        stage('cleanup') {
          step([$class: 'WsCleanup'])
        }
}
