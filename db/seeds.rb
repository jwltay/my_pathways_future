require 'faker'
require 'csv'

Faker::UniqueGenerator.clear

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

# End of Careers ===============================================================
# Global Careers ===============================================================
market_researcher = Career.find_by(name: "market research analyst")
accountant = Career.find_by(name: "accountant")
software_dev = Career.find_by(name: "software developer")
financial_analyst = Career.find_by(name: "financial analyst")
medical_scientist = Career.find_by(name: "medical scientist")
data_analyst = Career.find_by(name: "data analyst")
music_therapist = Career.find_by(name: "music therapist")
# End of Global Careers ========================================================

# Programmes ==================================================================
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

list_of_market_programmes = []
Programme.all.each do |programme|
  list_of_market_programmes << programme if programme.name.downcase.include?('market')
end

market_researcher.programmes = list_of_market_programmes

# music therapist

# list_of_music_programmes = []
# Programme.all.each do |programme|
#   list_of_music_programmes << programme if programme.name.downcase.include?('market')
# end

# music_therapist.programmes = list_of_music_programmes

# accountant
list_of_accounting_programmes = []
Programme.all.each do |programme|
  if programme.name.downcase.include?('account') || programme.name.downcase.include?('finance')
    list_of_accounting_programmes << programme
  end
end

accountant.programmes = list_of_accounting_programmes

# software developer
list_of_software_programmes = []
Programme.all.each do |programme|
  if programme.name.downcase.include?('information') || programme.name.downcase.include?('computer')
    list_of_software_programmes << programme
  end
end

software_dev.programmes = list_of_software_programmes

# financial analyst
list_of_finance_programmes = []
Programme.all.each do |programme|
  if programme.name.downcase.include?('finance') || programme.name.downcase.include?('business')
    list_of_finance_programmes << programme
  end
end

financial_analyst.programmes = list_of_finance_programmes

# medical scientist
list_of_medical_programmes = []
Programme.all.each do |programme|
  if programme.name.downcase.include?('biomed') || programme.name.downcase.include?('biological')
    list_of_medical_programmes << programme
  end
end

medical_scientist.programmes = list_of_medical_programmes

# data analyst
list_of_data_programmes = []
Programme.all.each do |programme|
  if programme.name.downcase.include?('analytics') || programme.name.downcase.include?('computer')
    list_of_data_programmes << programme
  end
end

data_analyst.programmes = list_of_data_programmes

## End of career_programmes =========================================================

# Soft_skills =======================================================================
SoftSkill.destroy_all if SoftSkill.exists?

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
User.destroy_all if User.exists?
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
Subject.destroy_all if Subject.exists?
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
Programme.all.each do |programme|
  pass
end
# End of Programme subjects=====================================================
