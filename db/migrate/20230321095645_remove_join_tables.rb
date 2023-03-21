class RemoveJoinTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :soft_skills_users
    drop_table :careers_soft_skills
    drop_table :subjects_users
    drop_table :programmes_subjects
    drop_table :careers_programmes
  end
end
