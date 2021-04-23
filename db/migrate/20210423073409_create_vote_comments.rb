class CreateVoteComments < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_comments do |t|
      t.references :user, foreign_key: {to_table: :users}
      t.references :comment, foreign_key: {to_table: :comments}
    end
  end
end
