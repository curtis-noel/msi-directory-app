node {
        stage('build') {
            checkout scm
        }

        stage('dockerize') {

          def app = docker.build("wolf685cln/msi-directory-${env.BRANCH_NAME}")
          docker.withRegistry('https://registry.hub.docker.com','docker-login') {
              app.push 'latest'
          }
        }

        stage('cleanup') {
          step([$class: 'WsCleanup'])
        }
}
