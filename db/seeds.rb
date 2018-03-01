require 'faker'

User.delete_all
Meetup.delete_all
Appearance.delete_all

u1 = User.create(
  provider: "github",
  uid: "1",
  username: "#{Faker::Simpsons.character}",
  email: "#{Faker::Internet.email}",
  avatar_url: "#{Faker::Avatar.image}"
)
u2 = User.create(
  provider: "github",
  uid: "2",
  username: "#{Faker::Simpsons.character}",
  email: "#{Faker::Internet.email}",
  avatar_url: "#{Faker::Avatar.image}"
)
u3 = User.create(
  provider: "github",
  uid: "3",
  username: "#{Faker::Simpsons.character}",
  email: "#{Faker::Internet.email}",
  avatar_url: "#{Faker::Avatar.image}"
)
u4 = User.create(
  provider: "github",
  uid: "4",
  username: "#{Faker::Simpsons.character}",
  email: "#{Faker::Internet.email}",
  avatar_url: "#{Faker::Avatar.image}"
)

m1 = Meetup.create(
  name: "#{Faker::Beer.style} Appreciation Night",
  location: "#{Faker::TwinPeaks.location}",
  creator: u1.username,
  description: "#{Faker::RickAndMorty.quote}"
)
m2 = Meetup.create(
  name: "#{Faker::Beer.style} Appreciation Night",
  location: "#{Faker::TwinPeaks.location}",
  creator: u2.username,
  description: "#{Faker::RickAndMorty.quote}"
)
m3 = Meetup.create(
  name: "#{Faker::Beer.style} Appreciation Night",
  location: "#{Faker::TwinPeaks.location}",
  creator: u3.username,
  description: "#{Faker::RickAndMorty.quote}"
)
m4 = Meetup.create(
  name: "#{Faker::Beer.style} Appreciation Night",
  location: "#{Faker::TwinPeaks.location}",
  creator: u4.username,
  description: "#{Faker::RickAndMorty.quote}"
)

Appearance.create(user_id: u1.id, meetup_id: m1.id)
Appearance.create(user_id: u1.id, meetup_id: m2.id)
Appearance.create(user_id: u1.id, meetup_id: m3.id)
Appearance.create(user_id: u2.id, meetup_id: m2.id)
Appearance.create(user_id: u2.id, meetup_id: m4.id)
Appearance.create(user_id: u3.id, meetup_id: m1.id)
Appearance.create(user_id: u3.id, meetup_id: m2.id)
Appearance.create(user_id: u3.id, meetup_id: m3.id)
Appearance.create(user_id: u4.id, meetup_id: m1.id)
Appearance.create(user_id: u4.id, meetup_id: m4.id)
