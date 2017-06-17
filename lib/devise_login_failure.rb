# This custom failure app lets us control where Warden (which Devise uses) redirects after
# a failed login attempt.  Unfortunately, there doesn't appear to be an easier way to do this
# within devise itself (a login failure hook would be nice from devise would be nice ...)

# This solution was taken from the top answer at Stackoverflow:
#    http://stackoverflow.com/questions/5832631/devise-redirect-after-login-fail
# A similiar solution is presented on the Devise wiki:
#    https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-when-the-user-can-not-be-authenticated

# The full solution required:
# 1. Defining this file
# 2. Modifying the devise.rb initializer to load the app.
# 3. Making sure Rails loaded this file by adding the lib directory to the Rails autoload_path in application.rb

class DeviseLoginFailure < Devise::FailureApp
  def redirect_url
    "/users/sign_in"
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end