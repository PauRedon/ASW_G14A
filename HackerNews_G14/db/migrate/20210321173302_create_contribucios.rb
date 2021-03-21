class CreateContribucios < ActiveRecord::Migration[6.1]
  def change
    create_table :contribucios do |t|
      t.string :tittle
      t.string :url
      t.text :content
      t.integer :likes
      t.integer :user_id

      t.timestamps
    end
  end
end
