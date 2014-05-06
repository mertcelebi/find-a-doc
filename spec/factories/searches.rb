# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    specialty { Faker::Lorem.word }
    symptom { Faker::Lorem.word }
    icd_9 "400"
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode "06511"
  end
end
