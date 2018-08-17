class CreateUserDramas < ActiveRecord::Migration[5.1]
  def change
    create_table :user_dramas do |t|
      t.references :user, foreign_key: true, null: false
      t.references :drama, foreign_key: true, null: false
      t.integer :episode_number, null: false
      t.integer :episode_length, null: false

      t.timestamps
    end

    add_index :user_dramas, [:user_id, :drama_id], name: 'index_on_user_and_drama'
    add_index :user_dramas, [:user_id, :drama_id, :episode_number], name: 'index_on_user_and_drama_and_episode'
    # Indexed on user by default by relation
  end
end
