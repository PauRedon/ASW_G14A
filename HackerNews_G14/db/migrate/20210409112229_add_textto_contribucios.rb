class AddTexttoContribucios < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucios, :texto, :text
  end
end
