class CreatePathways < ActiveRecord::Migration[7.0]
  def change
    create_table :pathways do |t|
      t.boolean :active, default: false, null: false
      t.boolean :primary, default: false, null: false
      t.references :user, null: false, foreign_key: true
      t.references :programme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
