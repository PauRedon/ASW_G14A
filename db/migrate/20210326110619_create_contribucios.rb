class CreateContribucios < ActiveRecord::Migration[6.1]
  def change
    create_table :contribucios do |t|
      t.string :tittle
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
