class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :individual_plant
end
