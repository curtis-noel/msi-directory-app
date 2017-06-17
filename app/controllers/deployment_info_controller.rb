# Deployment information
class DeploymentInfoController < ApplicationController
  include DeploymentInfoHelper
  # Deploy info
  def index
    @deployed_commit = deployed_commit
    @deployed_tag = deployed_tag(deployed_commit)
    @deployment_timestamp = deployment_timestamp
  end
end
