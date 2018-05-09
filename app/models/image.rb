class Image < ApplicationRecord
  belongs_to :plant
  mount_uploader :file, ImageUploader

  validates :file, presence: true
end
