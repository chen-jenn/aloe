class IndividualPlant < ApplicationRecord
  belongs_to :user
  validates :species_name, :individual_name, presence: true

  mount_uploader :photo, ImageUploader 
end
