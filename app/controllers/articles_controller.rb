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
    @articles = [] # Article.includes(:author).all
  end

  # returns a hash of hashes with articles first by year then by month
  # newest first
  def index_by_date
    @articles = Article.includes(:author).order("created_at desc")
    # hash (by year) of hash (by month) of array (of articles)
    @article_by_year_hash = Hash.new {|h,k| h[k] = Hash.new {|h2,k2| h2[k2] = Array.new}}
    @articles.each_with_object(@article_by_year_hash) {|article, hash| hash[article.created_at.year][article.created_at.month].push(article) }

  end

  def index_by_month
    @articles = Article.preload(:author).find_by_month(params[:month_id].to_i)
    flash.now.notice = @articles.empty?
  end

  def show
    @article = Article.includes(:author).find(params[:id])
    # add a stub for a comment
    @comment = Comment.new
    # don't add to the Article.comments collection because that will trigger a save/insert
    @comment.article = @article
    @article.increment_click_count
  end

  def new
    @article = Article.new
  end

  def create
    # @article = Article.new(params[:article])
    # create and save/persist the article
    @article = Article.new(article_params)
    @article.author=current_user
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
    # we can either restrict access here or in the page
    unless @article.author == current_user 
      flash.alert = "You must be the original author to edit this article"
      redirect_to request.referer
    end
  end
  
  def update
    @article = Article.find(params[:id])
    # update implicitly calls save
    @article.update(article_params)

    flash.notice= "Article '#{@article.title}' updated!'"

    redirect_to article_path
  end

end
