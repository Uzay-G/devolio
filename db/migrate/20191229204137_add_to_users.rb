class AddToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github, :string, default: nil
    add_column :users, :dribble, :string, default: nil
  end
end
