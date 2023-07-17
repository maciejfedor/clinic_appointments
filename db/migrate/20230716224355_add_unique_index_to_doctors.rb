class AddUniqueIndexToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_index :doctors, %i[first_name last_name], unique: true
  end
end
