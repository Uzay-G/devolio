class RemoveGithubFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :github, :string
  end
end
