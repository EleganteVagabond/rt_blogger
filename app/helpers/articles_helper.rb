module ArticlesHelper

  # require a param called article and associated params title and body
  def article_params
    params.require(:article).permit(:title,:body)
  end
end
