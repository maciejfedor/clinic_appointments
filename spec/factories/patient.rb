FactoryBot.define do
  factory :patient do
    first_name { "Jane" }
    last_name { "Doe " }
    city { "Warsaw" }
    sequence(:uid) { |n| "9#{n}022418684" }
    sequence(:date_of_birth) { |n| "199#{n}-02-24" }
    gender { "female" }
  end
end
