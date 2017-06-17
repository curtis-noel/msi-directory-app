class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.string :name

      t.timestamps
    end
    add_index :groupings, :name, :unique => true
  end
end
