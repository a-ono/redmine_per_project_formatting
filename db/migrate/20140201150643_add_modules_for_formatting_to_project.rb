class AddModulesForFormattingToProject < ActiveRecord::Migration
  def change
    add_column :projects, :modules_for_formatting, :text
  end
end
