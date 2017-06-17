class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name, :required => true
      t.text :contact_info
      t.string :email
      t.integer :state_id
      t.boolean :uscis, default: false
      t.integer :grouping_id

      t.timestamps
    end
    add_index :institutions, :name, :unique => false
  end
end
