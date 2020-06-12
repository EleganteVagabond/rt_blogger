module ArticlesHelper

  # require a param called article and associated params title and body
  # to use in the ArticleController be sure to include this module!
  private
  def article_params
    # tag list is the set of tags (M2M) and image is the paperclip image file
    params.require(:article).permit(:title,:body, :tag_list, :image)
  end

end
