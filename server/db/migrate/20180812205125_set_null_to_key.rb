class SetNullToKey < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :key, :string, :null => false
  end
end
