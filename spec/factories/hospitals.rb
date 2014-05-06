# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hospital do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    website { Faker::Internet.email }
  end
end
