class AuthorSessionsController < ApplicationController
  # can only logout if logged in
  before_action :require_login, only: [:destroy]

  def new 
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
    redirect_to(:authors, notice: 'Logged out!')
  end

end
