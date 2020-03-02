class EnableIntArrayExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension "intarray"
  end
end
