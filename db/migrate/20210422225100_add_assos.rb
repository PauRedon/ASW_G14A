class AddAssos < ActiveRecord::Migration[6.1]
  def change
    change_table :votes do |t|
      t.references :user, foreign_key: {to_table: :users}
      t.references :contribucio, foreign_key: {to_table: :contribucios}
    end
  end
end
