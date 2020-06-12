module ArticlesHelper

  # require a param called article and associated params title and body
  # to use in the ArticleController be sure to include this module!
  private
  def article_params
    params.require(:article).permit(:title,:body)
  end

end
