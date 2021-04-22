class Addassociations < ActiveRecord::Migration[6.1]
  def change
    change_table :contribucios do |t|
      t.belongs_to :user
    end
  end
end
