class Image < ApplicationRecord
  belongs_to :plant
  validates :file, presence: true

  mount_uploader :file, ImageUploader
end
