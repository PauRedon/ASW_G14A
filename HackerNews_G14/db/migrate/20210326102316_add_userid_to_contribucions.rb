class AddUseridToContribucions < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucions, :userid, :integer
  end
end
