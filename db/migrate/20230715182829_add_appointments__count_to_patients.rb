class AddAppointmentsCountToPatients < ActiveRecord::Migration[7.0]
  def self.up
    add_column :patients, :appointments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :patients, :appointments_count
  end
end
