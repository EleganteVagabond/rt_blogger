module AuthorsHelper
  private
  def comment_params 
    params.require(:author).permit(:username, :email, :nickname, :avatar)
  end
end
