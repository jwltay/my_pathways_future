class CreateEvent < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :programme, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :header
      t.string :highlight_hex

      t.timestamps
    end
  end
end
