# country, city, species_name, climate_zone, common_name, description

# climate_zones = ['Af', 'Am', 'As', 'Aw', 'BWk', 'BWh', 'BSk', 'BSh', 'Cfa', 'Cfb', 'Cfc', 'Csa', 'Csb', 'Csc', 'Cwa', 'Cwb', 'Cwc', 'Dfa', 'Dfb', 'Dfc', 'Dfd', 'Dsa', 'Dsb', 'Dsc', 'Dsd', 'Dwa', 'Dwb', 'Dwc', 'Dwd', 'EF', 'ET']
Plant.destroy_all 

plant_list = [
  ['haworthiopsis fasciata', 'Eastern cape', 'south africa', 'BSk'],
  ['aloe vera', 'Arabian peninsula', 'saudi arabia', 'BWh'],
  ['saintpaulia ionantha', 'N/A', 'Tanzania', 'Dfa'],
  ['Spathiphyllum wallisii', 'N/A', 'Colombia', 'Cfb'], # peace lily
  ['Calathea makoyana', 'State of Amazonas', 'Brazil', 'Af'], #peacock plant, cathedral windows
  ['Crassula ovata', 'N/A', 'Mozambique', 'Aw'], #jade plant
  ['Beaucarnea recurvata', 'Tamaullipa', 'Mexico', 'BSh'], #ponytail palm
  ['Phalaenopsis amabilis', 'N/A', 'Southeast Asia', 'Cwa'],
  ['Philodendron bipinnatifidum', 'N/A', 'West Indies', 'Dfa'],
  ['Epipremnum aureum', 'Mo\'orea', 'French Polynesia', 'Af'] # Devil's ivy
]

plant_list.each do |species, city, country, zone|
  Plant.create( species_name: species, city: city, country: country, climate_zone: zone )
end
