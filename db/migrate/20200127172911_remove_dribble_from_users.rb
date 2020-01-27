class RemoveDribbleFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :dribble, :string
  end
end
