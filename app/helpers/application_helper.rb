# VIEW HELPER FUNCTIONS - AVAILABLE IN ALL VIEWS
module ApplicationHelper
  include DeploymentInfoHelper

  def site_name
    'MSI Directory'
  end

  def site_version
    tag = deployed_tag
    tag.success ? " (#{tag.version})" : ""
  end

  def site_url
    if Rails.env.production?
      # Place your production URL in the quotes below
      'http://localhost:3333/'
    else
      # Our dev & test URL.
      'http://localhost:3333/'
    end
  end

  def meta_author
    'USCIS'
  end

  def meta_description
    'MSI Directory'
  end

  def meta_keywords
    'USCIS'
  end

  # Returns the full title on a per-page basis
  def full_title(page_title)
    if page_title.empty?
      site_name
    else
      "#{page_title} | #{site_name}"
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
