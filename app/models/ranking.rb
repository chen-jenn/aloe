class Ranking < ApplicationRecord
  belongs_to :plant
  belongs_to :user

  validates :user_id, uniqueness: { scope: :plant_id }
end
