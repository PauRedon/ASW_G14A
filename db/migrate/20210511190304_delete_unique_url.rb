class DeleteUniqueUrl < ActiveRecord::Migration[6.1]
  def change_table
    remove_index :contribucios, name: "index_contribucios_on_url"
  end
end
