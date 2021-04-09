class RemoveContent < ActiveRecord::Migration[6.1]
  def change
        remove_column :contribucios, :content
  end
end
