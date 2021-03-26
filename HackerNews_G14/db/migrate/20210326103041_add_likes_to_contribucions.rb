class AddLikesToContribucions < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucions, :likes, :integer, default: 0
  end
end
