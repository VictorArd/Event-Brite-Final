require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p '#' * 60
p 'DESTRUCTION DE LA BASE DE DONNEE EXISTANTE'
p '#' * 60

User.destroy_all
p 'Base de donnée des Utilisateurs détruite avec succès'

p '*' * 60

Event.destroy_all
p 'Base de donnée des Evènements détruite avec succès'

p '*' * 60

Attendance.destroy_all
p 'Base de donnée des Participations détruite avec succès'

p '#' * 60
p 'CREATION DE LA NOUVELLE BASE DE DONNEE'
p '#' * 60

  10.times do
  User.create!( email: "#{Faker::Name.first_name}@yopmail.com",
                password: 'azerty1234',
                password_confirmation: 'azerty1234',
                description: Faker::Quote.unique.matz[1..1000],
                first_name: Faker::Name.unique.first_name,
                last_name: Faker::Name.unique.last_name
              )
  end
  p 'Création de 10 Utilisateurs dans la BD'

  p '*' * 60

  10.times do
  Event.create!(  start_date: Faker::Date.forward(25),
                  duration: 5 * rand(1..10),
                  title: Faker::Coffee.blend_name[4..140],
                  description: Faker::Quote.unique.matz,
                  price: rand(1..1000),
                  location: Faker::Address.city,
                  admin_id: rand(User.first.id..User.last.id)
              )
  end
  p 'Création de 10 Evènements dans la BD'

  p '*' * 60

  10.times do
  Attendance.create!( stripe_customer_id: SecureRandom.urlsafe_base64,
                      user_id: rand(User.first.id..User.last.id),
                      event_id: rand(Event.first.id..Event.last.id)
                    )
  end
  p 'Création de 10 Participations dans la BD'

  p '*' * 60

  p '#' * 60
  p '#' * 60
