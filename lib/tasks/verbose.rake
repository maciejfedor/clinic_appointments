# switch rails logger to stdout
task v: :environment do 
  Rails.logger = Logger.new(STDOUT)
end
