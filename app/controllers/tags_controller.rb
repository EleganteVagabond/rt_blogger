class TagsController < ApplicationController

  before_action :require_login, only: [:destroy]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    begin 
      @tag = Tag.find(params[:id])
    rescue ActiveRecord::RecordNotFound 
      @tag = nil
    end
      unless @tag.nil?
        @tag.taggings.each do |tagging| 
          tagging.delete
        end 
        @tag.delete
        @tag.save
        
        flash.success= "Tag '#{@article.title}' deleted (aka unTagged)"
      end
  

    redirect_to tags_path
  end

end
