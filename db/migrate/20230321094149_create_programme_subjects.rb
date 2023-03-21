class CreateProgrammeSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :programme_subjects do |t|
      t.references :programme, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.timestamps
    end
  end
end
