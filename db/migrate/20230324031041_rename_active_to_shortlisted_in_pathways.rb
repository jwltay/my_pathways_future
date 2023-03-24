class RenameActiveToShortlistedInPathways < ActiveRecord::Migration[7.0]
  def change
    rename_column :pathways, :active, :shortlisted
  end
end
