# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
require 'faker'

User.delete_all
Meetup.delete_all
Appearance.delete_all

u1 = User.create(
  provider: "github",
  uid: "1",
  username: "jarlax1",
  email: "jarlax1@launchacademy.com",
  avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
)
u2 = User.create(
  provider: "github",
  uid: "2",
  username: "#{Faker::Internet.user_name}",
  email: "#{Faker::Internet.email}",
  avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
)
u3 = User.create(
  provider: "github",
  uid: "3",
  username: "#{Faker::Internet.user_name}",
  email: "#{Faker::Internet.email}",
  avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
)
u4 = User.create(
  provider: "github",
  uid: "4",
  username: "#{Faker::Internet.user_name}",
  email: "#{Faker::Internet.email}",
  avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
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
