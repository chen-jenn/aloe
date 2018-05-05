require 'csv'

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

# Country Table Generated Once
# COUNTRIES.each do |country| #a one time seed as this table will never change
#   Country.create( country_name: country )
# end

# climate_zones = ['Af', 'Am', 'As', 'Aw', 'BWk', 'BWh', 'BSk', 'BSh', 'Cfa', 'Cfb', 'Cfc', 'Csa', 'Csb', 'Csc', 'Cwa', 'Cwb', 'Cwc', 'Dfa', 'Dfb', 'Dfc', 'Dfd', 'Dsa', 'Dsb', 'Dsc', 'Dsd', 'Dwa', 'Dwb', 'Dwc', 'Dwd', 'EF', 'ET']

# Zone comparison table Generated Once
CSV.foreach(Rails.root.join('db/seeds/zone_comparison.csv'), headers:true) do |row|
  ZoneComparison.create do |instance|
    instance.user_zone = row[0]
    instance.plant_zone = row[1]
    instance.water_freq = row[2]
  end
end

# Plant.destroy_all
plant_list = [
  ['haworthiopsis fasciata', 'Eastern cape', 'BSk'],
  ['aloe vera', 'Arabian peninsula', 'BWh'],
  ['saintpaulia ionantha', '', 'Dfa'],
  ['Spathiphyllum wallisii', '', 'Cfb'], # peace lily
  ['Calathea makoyana', 'State of Amazonas', 'Af'], #peacock plant, cathedral windows
  ['Crassula ovata', '', 'Aw'], #jade plant
  ['Beaucarnea recurvata', 'Tamaullipa', 'BSh'], #ponytail palm
  ['Phalaenopsis amabilis', '', 'Cwa'],
  ['Philodendron bipinnatifidum', '', 'Dfa'],
  ['Epipremnum aureum', 'Mo\'orea', 'Af'] # Devil's ivy
]

plant_list.each do |species, city, zone|
  Plant.create( species_name: species, city: city, climate_zone: zone )
end

User.destroy_all

PASSWORD = 'password'

super_user = User.create(
  username: 'jonsnow',
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  city: 'Vancouver',
  country: 'Canada',
  password: PASSWORD
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
