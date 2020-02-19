class ChangeCommentsReferencesToNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :comments, :post, false
    change_column_null :comments, :user, false
  end
end
