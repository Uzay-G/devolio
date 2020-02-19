class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: {to_table: :users}
      t.references :followable, polymorphic: true
      t.timestamps
    end

    add_index :relationships, [:follower_id, :followable_id], unique: true
  end
end
