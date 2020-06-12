class Article < ApplicationRecord
  has_many :comments
  has_many :taggings

  has_many :tags, through: :taggings

  # tell ActiveStorage that this object has images attached to it
  has_one_attached :image
  # specify which attachments are valid (could include other image types)
  # validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png']
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

end
