class CommonName < ApplicationRecord
  belongs_to :plant
  validates :name, presence: true 
end
