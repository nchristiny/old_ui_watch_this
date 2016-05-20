class SessionsController < ApplicationController

  def new
    # if is_user_signed_in?
    #   flash[:warning] = 'You are already signed in!'
    #   redirect_to root_path
    # else
    #   @session = Session.new
    # end
  end

  def create
    if is_user_signed_in?
      flash[:warning] = 'You are already signed in!'
      redirect_to root_path
    else
      api_session = Session.new(params[:session])
      result = api_session.create
      session[:user_information] = extract_user_information(result)
      flash[:success] = 'You have successfully signed in!'
      redirect_to resolve_landing_path
    end
  rescue RestClient::Unauthorized
    @session = Session.new
    flash.now[:alert] = 'Invalid email or password'
    render :new
  end

  def destroy
    begin
      Session.destroy
    rescue RestClient::Unauthorized
      # In case the token has expired, the API will respond with 401. We do want to sign out the user though, thus
      # we handle the exception here instead of the default application controller handling.
    end
    session.delete :user_information
    flash[:success] = 'You have successfully signed out!'
    redirect_to root_path
  end

  private

  # Resolves if user should be redirected to a previously requested page or to home.
  def resolve_landing_path
    params[:return_to] || root_path
  end

  # Keep user information in a hash
  def extract_user_information(session_response)
    {
      id: session_response[:user][:id],
      email: session_response[:user][:email]
      # auth_token: session_response[:user][:auth_token]
    }
  end

end
