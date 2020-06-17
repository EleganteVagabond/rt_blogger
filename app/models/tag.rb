class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

  # define this to resolve issue with displaying tags and getting the weird memory address version
  def to_s
    name
  end

end
