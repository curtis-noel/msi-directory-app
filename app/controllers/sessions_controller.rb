class SessionsController < Devise::SessionsController
  def create
    # accepted_terms = params[:agree_to_terms] == "1"

    # unless accepted_terms
    #   flash[:alert] = "You must check the box stating that you have read, understand and agree to the terms and conditions."
    #   return redirect_to new_user_session_path
    # end
    super
  end
end
