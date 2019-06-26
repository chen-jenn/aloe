# README

Aloe is an application built using Ruby on Rails 5.1.6 that helps you get your plants watered in a timely manner according to specific species needs. The three main categories are: watering frequency, optimal temperature, and amount of sunlight. A lot of this information is added into the database through continous research and with the help of users (like you!). The database can then help generate a customized watering schedule for each one of your houseplants.

Who needs a green thumb now?

## Initial Setup After Cloning
System dependencies:
* requires Rails and bundler to be installed
* Carrierwave gem relies on ImageMagick for image file uploads

1. Navigate to the project directory and run `bundle`
2. Database creation: `rails db:create`
3. Create database tables: `rake db:schema:load`
4. Seeding data: `rails db:seed`

## How It Works
1. User adds a new plant that they own, for example, named 'George'
2. Certain fields (optimal_temp, sunlight, water_freq) in the 'George' record are generated by grabbing data from the existing plants database (as long as the species is actually in the main database)
3. An algorithm determines the watering interval and tells the user that they should water 'George' every ___ days. This is automatically set up with their text messaging system
4. On the 'George' show page, data from the three fields are also listed  

## Resources
#### Climate Zone API (http://climateapi.scottpinkelman.com/)
Used by this application to retrieve the Koppen-Geiger climate zone data for a particular plant species, based on the latitude and longitude of their native habitats.

#### Twilio API
Used to set up reminder texts for individual plants and when to water them next

### Disclaimer
While this app helps generate general plant care information based on user experience and Koppen-Geiger climate classification algorithms, it must also be noted that there are many more variables that need to be taken into account to calculate the optimal temperature or watering frequency of a plant (e.g. soil pH, soil volume, humidity, precipitation, and of course, genetics). This app does not claim to have the highest scientific accuracy and is best used only as a general guideline for houseplant care.
