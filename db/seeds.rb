# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# =======================================
User.destroy_all

u1 = User.new(
  name: "Joe",
  email: "joe@example.com",
  password: "password",
  role: "editor"
  )
  u1.save

u2 = User.new(
  name: "John",
  email: "john@example.com",
  password: "password",
  role: "regular"
  )
  u2.save


puts "*".center(40,"*")
puts
puts "#{User.count} users created".center(40)
puts " done seeding ".center(40)
puts
puts "*".center(40,"*")
