class SetNullToDramas < ActiveRecord::Migration[5.1]
  def change
    change_column :dramas, :title, :string, :null => false
    change_column :dramas, :site, :string, :null => false
    change_column :dramas, :link, :string, :null => false
    change_column :dramas, :latest_episode, :integer, :default => 0
  end
end
