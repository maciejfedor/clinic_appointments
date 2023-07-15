class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments, id: :uuid do |t|

      t.datetime :start_time, null: false
      t.decimal :price, null: false, precision: 8, scale: 2

      t.references :doctor, null: false, foreign_key: true, type: :uuid
      t.references :patient, null: false, foreign_key: true, type: :uuid


      t.timestamps
    end
    add_index :appointments, [:start_time, :doctor_id, :patient_id], unique: true
  end
end
