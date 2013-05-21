class AddTextFormattingToProject < ActiveRecord::Migration
  def change
    add_column :projects, :text_formatting, :string
  end
end
