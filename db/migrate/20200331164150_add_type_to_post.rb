class AddTypeToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :content_type, :string, default: "article"
  end
end
