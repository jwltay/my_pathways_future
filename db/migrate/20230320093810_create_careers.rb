class CreateCareers < ActiveRecord::Migration[7.0]
  def change
    create_table :careers do |t|
      t.integer :average_salary, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
