class AddTextFormattingToProject < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :text_formatting, :string
  end
end
