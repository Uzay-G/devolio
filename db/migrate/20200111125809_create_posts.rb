class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
