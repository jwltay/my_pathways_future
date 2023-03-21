class AddNameAndSummaryToCareers < ActiveRecord::Migration[7.0]
  def change
    add_column :careers, :name, :string, null: false
    add_column :careers, :summary, :text, null: false
  end
end
