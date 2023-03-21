class CreateSoftSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :soft_skills do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
