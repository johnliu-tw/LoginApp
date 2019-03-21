# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(id: 0, email: "aa@aa.com", password: "resetpassword", reset_token: "reset_token", reset_sent_at: "2020-01-01")
User.create!(id: 1, email: "bb@bb.com", password: "11111111", reset_token: "reset_token_incorrect_time", reset_sent_at: "2018-01-01")