module CommentsHelper
    
  # this is what creates the xx_params variable
  # to use in the CommentsController be sure to include this module!
  private
  def comment_params 
    params.require(:comment).permit(:author_name, :body)
  end

end
