class CreateDramas < ActiveRecord::Migration[5.1]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :site
      t.integer :latest_episode
      t.timestamp :latest_episode_update
      t.string :link
      t.string :thumbnail

      t.timestamps
    end

    add_index :dramas, [:title, :site], name: 'index_on_title_and_site'
  end
end
