class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true, null: false
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
    
  end
end
