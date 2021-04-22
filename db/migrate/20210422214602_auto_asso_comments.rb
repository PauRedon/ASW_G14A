class AutoAssoComments < ActiveRecord::Migration[6.1]
  def change
    change_table :comments do |t|
      t.references :parent, foreign_key: {to_table: :comments}
    end
  end
end
