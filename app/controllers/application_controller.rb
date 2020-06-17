class ApplicationController < ActionController::Base

  def not_authenticated
    flash.now.alert = "You must be logged in to do that"
    redirect_to root_path
  end
end
