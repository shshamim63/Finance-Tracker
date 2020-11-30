class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :friend_id
      t.integer :status

      t.timestamps
    end
    add_index :friendships, :status
    add_index :friendships, [:user_id, :friend_id]
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
