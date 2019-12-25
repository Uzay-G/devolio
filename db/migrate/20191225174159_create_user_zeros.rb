class CreateUserZeros < ActiveRecord::Migration[6.0]
  def change
    create_table :user_zeros do |t|
      t.string :email

      t.timestamps
    end
  end
end
