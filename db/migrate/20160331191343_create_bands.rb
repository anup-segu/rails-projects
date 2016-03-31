class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false
    end

    add_index :bands, :name, unique: true
  end
end
