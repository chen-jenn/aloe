Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

# COUNTRIES.each do |country| #a one time seed as this table will never change
#   Country.create( country_name: country )
# end

# climate_zones = ['Af', 'Am', 'As', 'Aw', 'BWk', 'BWh', 'BSk', 'BSh', 'Cfa', 'Cfb', 'Cfc', 'Csa', 'Csb', 'Csc', 'Cwa', 'Cwb', 'Cwc', 'Dfa', 'Dfb', 'Dfc', 'Dfd', 'Dsa', 'Dsb', 'Dsc', 'Dsd', 'Dwa', 'Dwb', 'Dwc', 'Dwd', 'EF', 'ET']
# Plant.destroy_all

# in order: countries [south africa, saudi arabia, tanzania, colombia, brazil, mozambique, mexico, southeast asia, west indies, french polynesia]

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

# plant_list.each do |species, city, zone|
#   Plant.create( species_name: species, city: city, climate_zone: zone )
# end

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
