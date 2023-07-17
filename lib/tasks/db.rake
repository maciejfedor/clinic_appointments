namespace :db do 
  namespace :seed do 
    task all: :environment do
    load(Rails.root.join("db", "seeds_base.rb"))
    load(File.join(Rails.root.join("db", "seeds", "all.rb")))
    end
  end
end