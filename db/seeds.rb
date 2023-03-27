require 'faker'
require 'csv'

Faker::UniqueGenerator.clear

puts "Clearing old data.."
CareerProgramme.destroy_all if CareerProgramme.exists?
CareerSoftSkill.destroy_all if CareerSoftSkill.exists?
ProgrammeSubject.destroy_all if ProgrammeSubject.exists?
User.destroy_all if User.exists?
Subject.destroy_all if Subject.exists?
Career.destroy_all if Career.exists?
Event.destroy_all if Event.exists?
Programme.destroy_all if Programme.exists?
SoftSkill.destroy_all if SoftSkill.exists?

careers_filepath = "db/careers.csv"
programmes_filepath = "db/programmes.csv"

puts "loading CSV for careers..."
# Careers =====================================================================
CSV.foreach(careers_filepath, headers: :first_row) do |row|
  career = Career.new(
    name: row['name'],
    average_salary: row['average_salary'].to_i,
    summary: row['summary'],
    responsibilities: row['responsibilities'],
    progression: row['progression'],
    education: row['education']
  )

  case row['name']
  when 'market research analyst'
    photo = File.open('app/assets/images/market-researcher.png')
    career.photo.attach(io: photo, filename: "market-researcher.png", content_type: "image/png")
  when 'accountant'
    photo = File.open('app/assets/images/accountant.png')
    career.photo.attach(io: photo, filename: "accountant.png", content_type: "image/png")
  when 'software developer'
    photo = File.open('app/assets/images/software-developer.png')
    career.photo.attach(io: photo, filename: "software-developer.png", content_type: "image/png")
  when 'financial analyst'
    photo = File.open('app/assets/images/financial-analyst.png')
    career.photo.attach(io: photo, filename: "financial-analyst.png", content_type: "image/png")
  when 'medical scientist'
    photo = File.open('app/assets/images/medical-scientist.png')
    career.photo.attach(io: photo, filename: "medical-scientist.png", content_type: "image/png")
  when 'data analyst'
    photo = File.open('app/assets/images/data-analyst.png')
    career.photo.attach(io: photo, filename: "data-analyst.png", content_type: "image/png")
  end

  career.save!
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

puts "Loading CSV for programmes..."
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

# Programme Events =================================================================
Programme.all.each do |p|
  Event.create(
    start_time: 4.days.ago,
    end_time: Time.now + 3.days,
    programme: p,
    highlight_hex: "A5DBD8",
    header: "Gather references from teachers"
  )

  Event.create(
    start_time: Time.now + 10.days,
    end_time: Time.now + 10.days,
    programme: p,
    highlight_hex: "E96479",
    header: "Application Deadline"
  )
end

# End of Programme Events ============================================================

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
  "Networking Skills",
  "Communication",
  "Confidence",
  "Organisation",
  "Problem Solving",
  "Proactive",
  "Fast Learner",
  "Self-Motivated",
  "Work Under Pressure",
  "Technical Savvy",
  "Teamwork",
  "Leadership",
  "Analytical Skills",
  "Critical Thinking",
  "Project Management"
]

puts "Creating Soft Skills..."
list_of_soft_skill.each do |soft_skill|
  SoftSkill.create!(name: soft_skill)
end
# End of Soft_skills ===========================================================

# Career Soft Skills ===========================================================
analytical = SoftSkill.find_by(name: "Analytical Skills")
critical = SoftSkill.find_by(name: "Critical Thinking")
communication = SoftSkill.find_by(name: "Communication")
problem_solving = SoftSkill.find_by(name: "Problem Solving")
teamwork = SoftSkill.find_by(name: "Teamwork")
motivated = SoftSkill.find_by(name: "Self-Motivated")

market_researcher.soft_skills << analytical
market_researcher.soft_skills << critical

music_therapist.soft_skills << communication
music_therapist.soft_skills << teamwork

accountant.soft_skills << analytical

software_dev.soft_skills << analytical
software_dev.soft_skills << problem_solving
software_dev.soft_skills << motivated

financial_analyst.soft_skills << analytical
financial_analyst.soft_skills << critical

medical_scientist.soft_skills << analytical
medical_scientist.soft_skills << critical

data_analyst.soft_skills << analytical
# END of Career Soft Skills ==================================================

# Users ======================================================================

puts "Creating Users..."
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
  email: "manu@gmail.com",
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

puts "Creating Subjects..."
list_of_subjects.each { |subject| Subject.create!(name: subject) }
# End of Subjects ==============================================================

# Programme subjects ===========================================================
Programme.where("name ILIKE ?", "%business%").each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
end

Programme.where("name ILIKE ?", "%account%")
         .or(Programme.where("name ILIKE ?", "%finance%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
  programme.subjects << Subject.find_by(name: "Economics")
end

Programme.where("name ILIKE ?", "%math%").each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
  programme.subjects << Subject.find_by(name: "English")
end

Programme.where("name ILIKE ?", "%bio%")
         .or(Programme.where("name ILIKE ?", "%bio%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Biology")
  programme.subjects << Subject.find_by(name: "Chemistry")
end

Programme.where("name ILIKE ?", "%computer%")
         .or(Programme.where("name ILIKE ?", "%information%")).each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
end

Programme.where("name ILIKE ?", "%law%").each do |programme|
  programme.subjects << Subject.find_by(name: "English")
end

Programme.where("name ILIKE ?", "%psych%").each do |programme|
  programme.subjects << Subject.find_by(name: "Mathematics")
end
# End of Programme subjects=====================================================

# ===========================FOR TESTING =======================================
manu = User.find_by(first_name: "Manu")

p1 = Programme.all.sample
# p2 = Programme.where.not(id: p1.id).sample

Pathway.create!(user: manu, programme: p1)
# Pathway.create!(user: manu, programme: p2)

puts "Done 🚀🚀🚀"
