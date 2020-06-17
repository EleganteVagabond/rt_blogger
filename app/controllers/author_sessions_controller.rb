class AuthorSessionsController < ApplicationController
  # can only logout if logged in
  before_action :require_login, only: [:destroy]

  def new
    # sorcery uses this session value in the #redirect_back_or_to method 
    # but it only gets updated by sorcery from a require_login call so let's set it here
    session[:return_to_url] = request.referer
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(articles_path, notice: 'Logged in successfully.')
    else
      flash.now[:notice] = "Login failed."
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to login_path , notice: 'Logged out!'
  end

end
