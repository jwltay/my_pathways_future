class RemoveDescriptionAddResponsibilitiesProgressionEducationToCareers < ActiveRecord::Migration[7.0]
  def change
    remove_column :careers, :description
    add_column :careers, :responsibilities, :text, null:false
    add_column :careers, :progression, :text, null:false
    add_column :careers, :education, :text, null:false
  end
end
