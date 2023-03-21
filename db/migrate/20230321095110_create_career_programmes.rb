class CreateCareerProgrammes < ActiveRecord::Migration[7.0]
  def change
    create_table :career_programmes do |t|
      t.references :career, null: false, foreign_key: true
      t.references :programme, null: false, foreign_key: true
      t.timestamps
    end
  end
end
