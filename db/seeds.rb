# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Plan.create!(
  price: 0.0,
  name: 'Free'
)

Plan.create!(
  price: 10.0,
  name: 'premium'
)

Plan.create!(
  price: 20.0,
  name: 'Amaze'
)

user1 = User.new(
  first_name: 'Shakhawat',
  last_name: 'Hossaim',
  username: 'shshamim63',
  email: 'shshamim63@gmail.com',
  password: '123456',
  plan: Plan.first
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  first_name: 'Bruce',
  last_name: 'Wayne',
  username: 'Batman',
  email: 'batman@gmail.com',
  password: '123456',
  plan: Plan.first
)
user2.skip_confirmation!
user2.save!

user3 = User.new(
  first_name: 'Dick',
  last_name: 'Grayson',
  username: 'Robin',
  email: 'robin@gmail.com',
  password: '123456',
  plan: Plan.second
)
user3.skip_confirmation!
user3.save!

user4 = User.new(
  first_name: 'Ben',
  last_name: 'Affleck',
  username: 'Suicide Squad',
  email: 'suicide.squad@gmail.com',
  password: '123456',
  plan: Plan.third
)
user4.skip_confirmation!
user4.save!

Friendship.create(
  user: User.first,
  friend: User.second,
  status: 'accepted'
)
Friendship.create(
  user: User.first,
  friend: User.third,
  status: 'accepted'
)
