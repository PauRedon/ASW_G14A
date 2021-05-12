class DeleteUnique < ActiveRecord::Migration[6.1]
  def change
    remove_index :contribucios, name: "index_contribucios_on_url"
  end
end
