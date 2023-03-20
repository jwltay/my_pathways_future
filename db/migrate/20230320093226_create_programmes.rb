class CreateProgrammes < ActiveRecord::Migration[7.0]
  def change
    create_table :programmes do |t|
      t.integer :tuition_fees
      t.integer :duration
      t.integer :rating
      t.text :description

      t.timestamps
    end
  end
end
