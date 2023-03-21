class CreateUserSoftSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :user_soft_skills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :soft_skill, null: false, foreign_key: true
      t.timestamps
    end
  end
end
