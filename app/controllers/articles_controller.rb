class ArticlesController < ApplicationController
  
  # I'm not sure what the difference is between these two. 
  # It doesn't seem to find the require_params method if I don't use include but the docs say the helper convention is the right way to go :/
  helper ArticlesHelper
  include ArticlesHelper

  # these are the same but one is explicit about which methods require login and the other only says which don't
  # I think I prefer the except so if anything is added it is automatically included/secured
  #before_action :require_login, only: [:new,:create,:edit,:update,:destroy]
  before_action :require_login, except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    # add a stub for a comment
    @comment = Comment.new
    # don't add to the Article.comments collection because that will trigger a save/insert
    @comment.article = @article
  end

  def new
    @article = Article.new
  end

  def create
    # @article = Article.new(params[:article])
    # create and save/persist the article
    @article = Article.new(article_params)
    @article.save
    # notify the user that it succeeded
    flash.notice= "Article '#{@article.title}' created. Good job, you!'"
    # now show the saved article
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.delete
    @article.save
    flash.success= "Article '#{@article.title}' deleted :'( Fare thee well article '"

    redirect_to article_path
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    # update implicitly calls save
    @article.update(article_params)

    flash.notice= "Article '#{@article.title}' updated!'"

    redirect_to article_path
  end

end
