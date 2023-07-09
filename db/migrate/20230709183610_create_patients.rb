class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender, null: false
      t.date :date_of_birth, null: false

      t.timestamps
    end
  end
end
