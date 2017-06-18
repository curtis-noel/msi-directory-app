module DeploymentInfoHelper

  DEPLOY_FILE_FULL_PATH = "#{Rails.root}/.git/refs/heads/deploy"
  TAGS_DIR_FULL_PATH = "#{Rails.root}/.git/refs/tags"
  MISSING_DEPLOY_FILE_ERROR_MSG = "Error: Could not get SHA from #{DEPLOY_FILE_FULL_PATH} (file missing)"
  EMPTY_DEPLOY_FILE_ERROR_MSG = "Error: Could not get SHA from #{DEPLOY_FILE_FULL_PATH} (file empty)"

  # Result Structs
  #################################################

  DeployedCommitResult = Struct.new(:success, :sha, :status_msg) do
    def sha_or_details
      success ? sha : status_msg
    end
  end

  DeployedTimeStampResult = Struct.new(:success, :timestamp, :status_msg) do
    def formatted_timestamp(format: "%m-%d-%Y %I:%M %p", timezone: "Eastern Time (US & Canada)")
      success ? self.timestamp.in_time_zone(timezone).strftime(format) : ""
    end
    def formatted_timestamp_or_details
      success ? formatted_timestamp : status_msg
    end
  end

  DeployedTagResult = Struct.new(:success, :full_path, :status_msg) do

    def tag_name_or_details
      success ? tag_name : status_msg
    end

    def tag_name
      success ? File.basename(full_path) : ""
    end

    def pretty_tag_name
      success ? tag_name.gsub!(/_/, ' ') : ""
    end

    def version
      return "" unless success
      version = pretty_tag_name
      idx = version.index("Release")
      version[idx, version.length]
    end

    def version_or_details
      success ? version : status_msg
    end

  end

  # Queries
  ##################################################
  # The query methods below will return an instance of one of the structs defined above.

EMPTY_DEPLOY_FILE_ERROR_MSG
  def deployed_commit
    unless File.file?(DEPLOY_FILE_FULL_PATH)
      return DeployedCommitResult.new(false, nil, MISSING_DEPLOY_FILE_ERROR_MSG)
    end

    sha = read_first_line_of_file(DEPLOY_FILE_FULL_PATH)

    if sha.blank?
      return DeployedCommitResult.new(false, nil, EMPTY_DEPLOY_FILE_ERROR_MSG)
    end

    DeployedCommitResult.new(true, sha)
  end


  # Check go ahead and perform the same checks as the deployed_commit method.  We
  # want to make sure we have a valid file that contains a valid SHA before
  # reporting a timestamp.  If an empty file exists, and we report a timestamp,
  # it will look funny.  If deployed_commit reports an issue then deployed_timestamp
  # should report an issue.
  def deployment_timestamp
    unless File.file?(DEPLOY_FILE_FULL_PATH)
      return DeployedTimeStampResult.new(false, nil, MISSING_DEPLOY_FILE_ERROR_MSG)
    end

    sha = read_first_line_of_file(DEPLOY_FILE_FULL_PATH)

    if sha.blank?
      return DeployedTimeStampResult.new(false, nil, EMPTY_DEPLOY_FILE_ERROR_MSG)
    end

    DeployedTimeStampResult.new(true, File.mtime(DEPLOY_FILE_FULL_PATH))
  end

  def deployed_tag(use_this_commit=nil)
    commit = use_this_commit.blank? ? self.deployed_commit : use_this_commit

    unless commit.success
      return DeployedTagResult.new(false, nil, commit.status_msg)
    end

    unless File.directory?(TAGS_DIR_FULL_PATH)
      return DeployedTagResult.new(false, nil, "Error: missing folder #{TAGS_DIR_FULL_PATH}")
    end

    Dir["#{TAGS_DIR_FULL_PATH}/*"].each do |full_file_path|
      if commit.sha == read_first_line_of_file(full_file_path)
        return DeployedTagResult.new(true, full_file_path)
      end
    end

    DeployedTagResult.new(false, nil, "None (could not match deployed commit SHA to a tag)")
  end

private

  def read_first_line_of_file(full_file_path)
    begin
       sha = File.open(full_file_path) {|f| f.readline}
    rescue EOFError #This will happen if the file is empty
       sha = ""
    end
    sha.strip
  end
end
