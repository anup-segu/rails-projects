class CreateUservotes < ActiveRecord::Migration
  def change
    create_table :uservotes do |t|
      t.integer :user_id, null: false
      t.integer :value, null: false
      t.integer :votable_id, null: false
      t.string :votable_type, null: false

      t.timestamps null: false
    end

    add_index :uservotes, :user_id
    add_index :uservotes, [:votable_id, :votable_type]
    add_index :uservotes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
