class CreateWatchingEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :watching_events do |t|
      t.references :user_drama, foreign_key: true, null: false
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
