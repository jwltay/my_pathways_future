class RemoveShortlistColumnAndAddStageToPathways < ActiveRecord::Migration[7.0]
  def change
    remove_column :pathways, :active
    add_column :pathways, :stage, :integer
  end
end
