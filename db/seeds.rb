require 'faker'

Faker::UniqueGenerator.clear

# Users
User.destroy_all if User.exists?
5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "password",
    occupation: "student"
  )
end

# Subjects
Subject.destroy_all if Subject.exists?
20.times do
  Subject.create!(
    name: Faker::Educator.unique.subject
  )
end

# Soft_skills
SoftSkill.destroy_all if SoftSkill.exists?
10.times do
  SoftSkill.create!(
    name: Faker::Job.unique.key_skill
  )
end

# Programmes
Programme.destroy_all if Programme.exists?
10.times do
  Programme.create!(
    name: Faker::Educator.unique.degree,
    tuition_fees: (rand(15000..40000)/100) * 100,
    duration: rand(3..4),
    rating: rand(3.5..5.0).round(1),
    university: Faker::Educator.unique.university,
    summary: Faker::Lorem.paragraph(sentence_count: 2),
    overview: Faker::Lorem.paragraph(sentence_count: 10)
  )
end

# careers
20.times do
  Career.create!(
    name: Faker::Job.unique.title,
    average_salary: (rand(2000..5000)/100) * 100,
    summary: Faker::Lorem.paragraph(sentence_count: 2),
    responsibilities: ["manage", 'follow orders', 'lead', 'monitor'].sample,
    progression: Faker::Job.title,
    education: Faker::Job.education_level
  )
end
