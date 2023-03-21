class CreateCareerSoftSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :career_soft_skills do |t|
      t.references :career, null: false, foreign_key: true
      t.references :soft_skill, null: false, foreign_key: true
      t.timestamps
    end
  end
end
