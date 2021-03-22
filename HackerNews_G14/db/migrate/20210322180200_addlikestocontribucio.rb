class Addlikestocontribucio < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucios, :likes, :integer, default: 0
    add_column :contribucios, :userid, :integer
  end
end
