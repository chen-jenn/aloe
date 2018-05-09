require 'csv'

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

# climate_zones = ['Af', 'Am', 'As', 'Aw', 'BWk', 'BWh', 'BSk', 'BSh', 'Cfa', 'Cfb', 'Cfc', 'Csa', 'Csb', 'Csc', 'Cwa', 'Cwb', 'Cwc', 'Dfa', 'Dfb', 'Dfc', 'Dfd', 'Dsa', 'Dsb', 'Dsc', 'Dsd', 'Dwa', 'Dwb', 'Dwc', 'Dwd', 'EF', 'ET']

# 1. Country Table Generated Once
# COUNTRIES.each do |country| #a one time seed as this table will never change
#   Country.create( country_name: country )
# end

# 2. Zone comparison table Generated Once
# CSV.foreach(Rails.root.join('db/seeds/zone_comparison.csv'), headers:true) do |row|
#   ZoneComparison.create do |instance|
#     instance.user_zone = row[0]
#     instance.plant_zone = row[1]
#     instance.water_freq = row[2]
#   end
# end

User.destroy_all
Plant.destroy_all
PASSWORD = 'password'

super_user = User.create(
  username: 'jonsnow',
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  city: 'Vancouver',
  country: 'Canada',
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    username: Faker::Internet.user_name,
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    city: Faker::Address.city,
    country: Faker::Address.country,
    password: PASSWORD
  )
end

users = User.all
puts Cowsay.say "Created #{users.count} users", :tux
puts "Login with  #{super_user.email} and password of '#{PASSWORD}'"

CSV.foreach(Rails.root.join('db/seeds/plants.csv'), headers:true) do |row|
  Plant.create do |instance|
    instance.species_name = row[0]
    instance.city = row[1]
    instance.climate_zone = row[2]
    instance.latitude = row[3]
    instance.longitude = row[4]
    instance.sunlight = row[5]
    instance.temp_min = row[6]
    instance.temp_max = row[7]
    instance.user = super_user
  end
end

# Creating one record sample
# p = Plant.create(
#   species_name: "Doggo doggos",
#   city: "Vancouver",
#   climate_zone: "Dfa",
#   notes: Faker::HitchHikersGuideToTheGalaxy.quote
# )
#
# p.plant_countries.create(country_id: 17)
# p.common_names.create(name: Faker::Pokemon.name)
