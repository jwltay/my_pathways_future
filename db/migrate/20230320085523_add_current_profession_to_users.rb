class AddCurrentProfessionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_profession, :string
  end
end
