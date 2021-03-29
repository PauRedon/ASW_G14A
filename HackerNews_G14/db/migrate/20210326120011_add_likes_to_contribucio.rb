class AddLikesToContribucio < ActiveRecord::Migration[6.1]
  def change
    add_column :contribucios, :like, :integer, default: 0
  end
end
