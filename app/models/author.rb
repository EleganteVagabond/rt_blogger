class Author < ApplicationRecord
  authenticates_with_sorcery!

  # tell ActiveStorage that this object has images attached to it
  has_one_attached :avatar
  # specify which attachments are valid (could include other image types)
  validates :avatar, content_type:  ['image/jpg', 'image/jpeg', 'image/png']
  validates_confirmation_of :password, message: 'Password mismatch. Please try again', if: :password
end
