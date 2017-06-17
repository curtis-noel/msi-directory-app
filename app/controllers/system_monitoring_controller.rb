# This method is called by a external monitoring tool.  If "<status>OK</status>" is
# returned then it is assumed the app is working correctly.  If any other string is
# returned then an it is assumed the app has an error.
class SystemMonitoringController < ApplicationController
  # Any checks can be performed in this method.
  def health_check
    render :text => ActiveRecord::Base.connected? ? "<status>OK</status>" : ""
  end
end
