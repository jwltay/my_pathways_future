class RemoveDescriptionAddSummaryNameUniversityOverviewToProgrammes < ActiveRecord::Migration[7.0]
  def change
    remove_column :programmes, :description
    add_column :programmes, :summary, :text, null: false
    add_column :programmes, :name, :string, null: false
    add_column :programmes, :university, :string, null: false
    add_column :programmes, :overview, :text, null: false
  end
end
