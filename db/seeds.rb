# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
User.create(first_name: "Dave", last_name: "Smith", email: "foo@bar.baz", password: "foobar")
User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "foobar")
User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "foobar")
User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "foobar")

# Create Contacts
Contact.create(user_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 2, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 2, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 3, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 3, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 4, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)
Contact.create(user_id: 4, first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, nickname: Faker::Name.initials, email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), confirmed_at: Time.now.utc)

# Create Events
Event.create(contact_id: 1, user_id: 1, interaction_type: 'call', description: "made a call, talked about cats.", 
    date: Faker::Date.between(from: 4.days.ago, to: Date.today))
Event.create(contact_id: 1, user_id: 1, interaction_type: 'text', description: "Texted about fish.", 
    date: Faker::Date.forward(days: 3))
Event.create(contact_id: 2, user_id: 1, interaction_type: 'mail', description: "Recieved a letter, how odd.", 
    date: Faker::Date.between(from: 4.days.ago, to: Date.today))
Event.create(contact_id: 2, user_id: 1, interaction_type: 'solo_encounter', description: "Met up in the park and played catch.", 
    date: Faker::Date.forward(days: 12))
Event.create(contact_id: 1, user_id: 2, interaction_type: 'call', description: "made a call, Invited to a birthday party.", 
    date: Faker::Date.between(from: 4.days.ago, to: Date.today))
Event.create(contact_id: 1, user_id: 3, interaction_type: 'email', description: "Sent an email about a job posting.", 
    date: Faker::Date.between(from: 4.days.ago, to: Date.today))
Event.create(contact_id: 1, user_id: 4, interaction_type: 'call', description: "made a call, talked about cats.", 
    date: Faker::Date.between(from: 4.days.ago, to: Date.today))