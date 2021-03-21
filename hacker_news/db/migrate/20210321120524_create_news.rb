class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :tittle
      t.string :url
      t.text :content
      t.date :data_creacio
      t.integer :likes
      t.integer :user_id

      t.timestamps
    end
  end
end
