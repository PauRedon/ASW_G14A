class CreateContribucios < ActiveRecord::Migration[6.1]
  def change
    create_table :contribucios do |t|
      t.string :title
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
