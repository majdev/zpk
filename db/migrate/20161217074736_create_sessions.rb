class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :sessid, null: false
      t.string :sessdata

      t.timestamps
    end
    add_index :sessions, :sessid, unique: true
  end
end
