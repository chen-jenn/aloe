class IndividualPlant < ApplicationRecord
  belongs_to :user
  has_one :reminder, dependent: :destroy # active record still creates a second reminder for the same plant; fix later 
  before_validation :capitalize
  validates :species_name, :individual_name, presence: true

  mount_uploader :photo, ImageUploader

  def capitalize
    species_name.capitalize!
  end

  def get_water_freq(user_zone, plant_species)
    plant_zone = (Plant.where({ species_name: plant_species }).pluck :climate_zone)[0]
    (ZoneComparison.where({ user_zone: user_zone, plant_zone: plant_zone }).pluck :water_freq)[0]
  end

  def get_ranking
    # average of all existing rankings for that particular plant species
    i = self.species_name
    plant_id = (Plant.where({species_name: i}).pluck :id)[0]
    rankings = Ranking.where({plant_id: plant_id}).pluck :ease_of_care

    # Make into an array and count up each instance of a easy, moderate, hard
    easy = 0
    moderate = 0
    hard = 0

    rankings.each do |e|
      if e == 'easy'
        easy += 1
      elsif e == 'moderate'
        moderate += 1
      elsif e == 'hard'
        hard += 1
      end
    end

    tallied = [easy,moderate,hard]

    if tallied.max == easy && easy != 0
      'easy'
    elsif tallied.max == moderate && moderate != 0
      'moderate'
    elsif tallied.max == hard && hard != 0
      'hard'
    else
      'Not enough data'
    end
  end

  def get_sunlight(plant)
    (Plant.where({ species_name: plant }).pluck :sunlight)[0]
  end

  def get_optimal_temp(plant)
    min = (Plant.where({ species_name: plant }).pluck :temp_min)[0]
    max = (Plant.where({ species_name: plant }).pluck :temp_max)[0]
    "#{min}-#{max}"
  end

  def send_text(plant)
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "Reminder to water #{plant.individual_name} today!",
        to: "#{self.user.phone}",
        from: ENV['TWILIO_NUMBER'])
    "Reminder has been sent"
  end

end
