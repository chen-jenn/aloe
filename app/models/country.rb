class Country < ApplicationRecord #make it once and don't need to edit, no one can edit this list or is very rare  
  validates :country_name, presence: true
end
