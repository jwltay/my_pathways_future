# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# temporary user and careers for testing
# manu = User.create!(first_name: "Manu", email: "manu@email.com", password: "password", occupation: "student")

manu = User.first

nus = Programme.create!(name: "bsc cs", university: "nus", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)
ntu = Programme.create!(name: "bsc cs", university: "ntu", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)
math = Programme.create!(name: "bsc mathematics", university: "ntu", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)


swe = Career.create!(name: "swe", average_salary: 5000, summary: "summary", responsibilities: "responsibilities", progression: "progression", education: "education")
da = Career.create!(name: "data analyst", average_salary: 5000, summary: "summary", responsibilities: "responsibilities", progression: "progression", education: "education")

math.careers << da
math.careers << swe
nus.careers << swe
ntu.careers << swe


Pathway.create!(user: manu, programme: nus, active: true)
Pathway.create!(user: manu, programme: ntu, active: true)
Pathway.create!(user: manu, programme: math, active: true)

Subject.create!(name: "Mathematics")
Subject.create!(name: "Biology")
Subject.create!(name: "Chemistry")
Subject.create!(name: "Music")
Subject.create!(name: "English")
Subject.create!(name: "History")
Subject.create!(name: "Geography")

SoftSkill.create!(name: "Communication")
SoftSkill.create!(name: "Analytical Skills")
SoftSkill.create!(name: "Critical Thinking")
SoftSkill.create!(name: "Leadership")
SoftSkill.create!(name: "Project Management")
