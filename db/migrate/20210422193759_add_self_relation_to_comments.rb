class AddSelfRelationToComments < ActiveRecord::Migration[6.1]
  def change
    change_table :comments do |t|
      t.references :parent_comment, foreign_key: {to_table: :comments}
    end
  end
end
