# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
User.create!(
  [
    {
      email: 'john.doe@example.com',
      password: 'john.doe@example.com'
    }
  ]
)
p "Created #{User.count} Users"

Listing.create!(
  [
    {
      title: '🚙 Private Garage 🏙 Center City Roofdeck w 🔥Hot Tub',
      url: 'https://www.airbnb.com/h/roofdeckhottub',
      user: User.first
    }
  ]
)
p "Created #{Listing.count} Listings"

Review.create!(
  [
    {
      text: 'to improve the cleanliness,',
      stars: 3,
      author: 'Andrea Carolina',
      listing: Listing.first
    },
    {
      text: 'Cory’s place is fantastic. The location is central to everything. Walkable to many restaurants and a very short drive from literally anything we wanted to do. The house itself is great. Tons of space and very comfortable. Our kids loved the oversized bunk beds. The roof deck is awesome and the hot tub is superb. Cory himself was a fabulous host, responding *immediately* whenever we had a question, and providing great reccos for local places to eat that we truly enjoyed. We would love to stay again and will recommend to our friends as well.',
      stars: 5,
      author: 'Andy',
      listing: Listing.first
    }
  ]
)
p "Created #{Review.count} Reviews"
