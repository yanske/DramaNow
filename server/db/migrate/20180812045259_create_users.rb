class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :key, index: { unique: true }

      t.timestamps
    end
  end
end
