class AddUniqueUrl < ActiveRecord::Migration[6.1]
  def change
    add_index :contribucios, :url, unique: true
  end
end
