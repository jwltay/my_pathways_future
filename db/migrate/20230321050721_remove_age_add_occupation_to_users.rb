class RemoveAgeAddOccupationToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :age
    add_column :users, :occupation, :string, null: false
  end
end
