class CreateContribucions < ActiveRecord::Migration[6.1]
  def change
    create_table :contribucions do |t|
      t.string :title
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
