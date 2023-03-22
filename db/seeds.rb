require 'faker'
require 'csv'

Faker::UniqueGenerator.clear

CareerProgramme.destroy_all if CareerProgramme.exists?
CareerSoftSkill.destroy_all if CareerSoftSkill.exists?
ProgrammeSubject.destroy_all if ProgrammeSubject.exists?
User.destroy_all if User.exists?
Subject.destroy_all if Subject.exists?
Career.destroy_all if Career.exists?
Programme.destroy_all if Programme.exists?
SoftSkill.destroy_all if SoftSkill.exists?

careers_filepath = "db/careers.csv"
programmes_filepath = "db/programmes.csv"

# Careers =====================================================================
CSV.foreach(careers_filepath, headers: :first_row) do |row|
  Career.create!(
    name: row['name'],
    average_salary: row['average_salary'].to_i,
    summary: row['summary'],
    responsibilities: row['responsibilities'],
    progression: row['progression'],
    education: row['education']
  )
end
# Global Careers ===============================================================
market_researcher = Career.find_by(name: "market research analyst")
accountant = Career.find_by(name: "accountant")
software_dev = Career.find_by(name: "software developer")
financial_analyst = Career.find_by(name: "financial analyst")
medical_scientist = Career.find_by(name: "medical scientist")
data_analyst = Career.find_by(name: "data analyst")
music_therapist = Career.find_by(name: "music therapist")
# End of Careers ==============================================================

# Programmes =================================================================

CSV.foreach(programmes_filepath, headers: :first_row) do |row|
  Programme.create!(
    name: row['name'],
    university: row['university'],
    summary: row['summary'],
    overview: row['overview'],
    duration: row['duration'].to_i,
    tuition_fees: row['tuition_fees'].to_i,
    rating: row['rating'].to_i
  )
end
# End of Programmes ============================================================

## career_programmes =========================================================
# market research analyst
market_researcher.programmes = Programme.where("name ILIKE ?", "%market%")

# music therapist

# accountant
accountant.programmes = Programme.where("name ILIKE ?", "%account%")
                                 .or(Programme.where("name ILIKE ?", "%finance%"))

# software developer
software_dev.programmes = Programme.where("name ILIKE ?", "%information%")
                                   .or(Programme.where("name ILIKE ?", "%computer%"))

# financial analyst
financial_analyst.programmes = Programme.where("name ILIKE ?", "%finance%")
                                        .or(Programme.where("name ILIKE ?", "%business%"))

# medical scientist
medical_scientist.programmes = Programme.where("name ILIKE ?", "%biomed%")
                                        .or(Programme.where("name ILIKE ?", "%biological%"))

# data analyst
data_analyst.programmes = Programme.where("name ILIKE ?", "%analytics%")
                                   .or(Programme.where("name ILIKE ?", "%computer%"))
## End of career_programmes =========================================================

# Soft_skills =======================================================================
list_of_soft_skill = [
  "Networking skills",
  "Communication",
  "Confidence",
  "Organisation",
  "Problem solving",
  "Proactive",
  "Fast learner",
  "Self-motivated",
  "Work under pressure",
  "Technical savvy",
  "Teamwork",
  "Leadership",
  "Analytical Skills",
  "Critical Thinking",
  "Project Management"
]

list_of_soft_skill.each do |soft_skill|
  SoftSkill.create!(name: soft_skill)
end
# End of Soft_skills ===========================================================

# Career Soft Skills ===========================================================
analytical = SoftSkill.find_by(name: "Analytical Skills")
critical = SoftSkill.find_by(name: "Critical Thinking")
communication = SoftSkill.find_by(name: "Communication")
problem_solving = SoftSkill.find_by(name: "Problem solving")

market_researcher.soft_skills << analytical
market_researcher.soft_skills << critical

music_therapist.soft_skills << communication

accountant.soft_skills << analytical

software_dev.soft_skills << analytical
software_dev.soft_skills << problem_solving

financial_analyst.soft_skills << analytical
financial_analyst.soft_skills << critical

medical_scientist.soft_skills << analytical
medical_scientist.soft_skills << critical

data_analyst.soft_skills << analytical
# END of Career Soft Skills ==================================================

# Users ======================================================================

5.times do
  loop_name = Faker::Name.first_name
  User.create!(
    first_name: loop_name,
    last_name: Faker::Name.last_name,
    email: "#{loop_name}@#{['gmail', 'yahoo', 'hotmail'].sample}.#{['com', 'sg'].sample}",
    password: "password",
    occupation: %w[student fresh\ grad working\ adult].sample
  )
end

User.create!(
  first_name: "Manu",
  last_name: "Nonsense",
  email: "manu@#{['gmail', 'yahoo', 'hotmail'].sample}.#{['com', 'sg'].sample}",
  password: "password",
  occupation: "student"
)
# End of Users =================================================================

# Subjects ====================================================================

list_of_subjects = [
  "Art",
  'Economics',
  'English',
  'Geography',
  'History',
  'Music',
  'Theatre Studies and Drama',
  'Biology',
  'Chemistry',
  'Physics',
  'Mathematics',
  'Computing'
]
list_of_subjects.each { |subject| Subject.create!(name: subject) }
# End of Subjects ==============================================================

# Programme subjects ===========================================================
Programme.where("name ILIKE ?", "%market%").each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
  programme.subjects << Subject.find_by(name: "Economics")
end

Programme.where("name ILIKE ?", "%account%")
         .or(Programme.where("name ILIKE ?", "%finance%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
  programme.subjects << Subject.find_by(name: "Economics")
end

Programme.where("name ILIKE ?", "%math%").each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
end

Programme.where("name ILIKE ?", "%med%")
         .or(Programme.where("name ILIKE ?", "%bio%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Biology")
  programme.subjects << Subject.find_by(name: "Chemistry")
end

Programme.where("name ILIKE ?", "%computer%")
         .or(Programme.where("name ILIKE ?", "%information%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Computing")
end

Programme.where("name ILIKE ?", "%law%").each do |programme|
  programme.subjects << Subject.find_by(name: "English")
end
# End of Programme subjects=====================================================

# ===========================FOR TESTING =======================================
# manu = User.first

# nus = Programme.create!(name: "bsc cs", university: "nus", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)
# ntu = Programme.create!(name: "bsc cs", university: "ntu", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)
# math = Programme.create!(name: "bsc mathematics", university: "ntu", tuition_fees: 30000, summary: "summary", overview: "overview", duration: 4, rating: 5)

# swe = Career.create!(name: "swe", average_salary: 5000, summary: "summary", responsibilities: "responsibilities", progression: "progression", education: "education")
# da = Career.create!(name: "data analyst", average_salary: 5000, summary: "summary", responsibilities: "responsibilities", progression: "progression", education: "education")

# math.careers << da
# math.careers << swe
# nus.careers << swe
# ntu.careers << swe

# Pathway.create!(user: manu, programme: nus, active: true)
# Pathway.create!(user: manu, programme: ntu, active: true)
# Pathway.create!(user: manu, programme: math, active: true)

# Subject.create!(name: "Mathematics")
# Subject.create!(name: "Biology")
# Subject.create!(name: "Chemistry")
# Subject.create!(name: "Music")
# Subject.create!(name: "English")
# Subject.create!(name: "History")
# Subject.create!(name: "Geography")

# SoftSkill.create!(name: "Communication")
# SoftSkill.create!(name: "Analytical Skills")
# SoftSkill.create!(name: "Critical Thinking")
# SoftSkill.create!(name: "Leadership")
# SoftSkill.create!(name: "Project Management")
