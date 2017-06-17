node {
        stage("build") {
            checkout scm

            docker.image('ruby:2.3.1').inside {
              stage("install bundler") {
                sh "gem install bundler --no-rdoc --no-ri"
              }

              stage("installing dependencies") {
                sh "set RAILS_ENV=development"
                sh "bundle install"
              }

              stage("initializing database") {
                sh "rake db:drop && rake db:create && rake db:migrate && rake db:seed"
              }

              stage("Build package") {
                sh "rake build:deb"
              }

              stage("archive package") {
                archive (includes: 'pkg/*.deb')
              }

           }

        }

        // Clean up workspace
        step([$class: 'WsCleanup'])

}
