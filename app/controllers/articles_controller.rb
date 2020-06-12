class ArticlesController < ApplicationController
  include ArticlesHelper
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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
    flash.notice= "Article '#{@article.title}' deleted :'( Fare thee well article '"

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
