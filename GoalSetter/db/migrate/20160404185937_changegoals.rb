class Changegoals < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, default: true
    add_column :goals, :progress, :string, default: 'Not Started'
  end
end
