class AddCityAndUidToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :city, :string, null: false
    add_column :patients, :uid, :string, null: false 
    add_index :patients, :uid, unique: true
  end
end
