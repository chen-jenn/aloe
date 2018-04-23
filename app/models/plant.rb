class Plant < ApplicationRecord
  belongs_to :user 

  has_many :common_names, dependent: :destroy
  accepts_nested_attributes_for :common_names

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :plant_countries, dependent: :destroy #plant record destroyed removes the plant_country relation
  has_many :countries, through: :plant_countries
  validate :has_at_least_one_country

  before_validation :capitalize
  validates :species_name, presence: true, uniqueness: true
  validates_length_of :climate_zone, maximum: 3, allow_blank: true
  validates_associated :common_names
  # validates_associated :images

  private
  def capitalize
    species_name.capitalize!
    city.titleize
  end

  def has_at_least_one_country
    if countries.empty?
      errors.add(:plant, "needs at least one country")
    end
  end
end
