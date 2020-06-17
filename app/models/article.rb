class Article < ApplicationRecord
  has_many :comments
  has_many :taggings

  has_many :tags, through: :taggings

  belongs_to :author

  # tell ActiveStorage that this object has images attached to it
  has_one_attached :image
  # specify which attachments are valid (could include other image types)
  validates :image, content_type:  ['image/jpg', 'image/jpeg', 'image/png']

  def tag_list
    self.tags.collect do |tag| 
      tag.name
    end.join(',')
  end

  def tag_list=(tags_string)
    tag_arr = tags_string.split(',').collect {|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_arr.collect {|tag_name| Tag.find_or_create_by(name: tag_name)}
    self.tags = new_or_found_tags
  end

  def increment_click_count
    self.click_count += 1
    self.save
  end

  # bizarre, this has to be self. for access in the controller but
  # the function below can't be referenced if it has a self. ????
  def self.find_by_month(month)
    @articles = Article.all.includes(:author)
    # hash (by year) of hash (by month) of array (of articles)
    @articles.each_with_object([]) {|article, arr| arr.push(article) if article.created_at.month==month}
  end

  def self.most_popular
    Article.includes(:author).order("click_count desc").limit(3)
  end

end
