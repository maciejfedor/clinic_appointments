# Run with verbose task to get logger info => rake v import:patients
namespace :import do 
  desc "Import patients from CSV file" 
  task patients: :environment do  
    DataImport::ImportPatients.call
  end
end