class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.string :source
      t.text :description
      t.string :name

      t.timestamps
    end
    add_index :projects, [:user_id, :created_at]
  end
end
