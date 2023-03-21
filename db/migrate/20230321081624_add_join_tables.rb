class AddJoinTables < ActiveRecord::Migration[7.0]
  def change
    create_table :soft_skills_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :soft_skill, null: false, foreign_key: true
    end

    create_table :careers_soft_skills do |t|
      t.references :career, null: false, foreign_key: true
      t.references :soft_skill, null: false, foreign_key: true
    end

    create_table :subjects_users do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end

    create_table :programmes_subjects do |t|
      t.references :programme, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
    end

    create_table :careers_programmes do |t|
      t.references :career, null: false, foreign_key: true
      t.references :programme, null: false, foreign_key: true
    end
  end
end
