class AddModulesForFormattingToProject < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :modules_for_formatting, :text
  end
end
