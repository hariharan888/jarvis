FactoryBot.define do
  factory :stock do
    name { Faker::Company.name }
    ticker { Faker::Lorem.characters(number: 5).upcase }
    exchange { Faker::Company.name }
    isin { Faker::Lorem.characters(number: 12).upcase }
    company_name { Faker::Company.name }
    bse_code { Faker::Number.number(digits: 3) }
    nse_code { Faker::Lorem.characters(number: 5).upcase }
    sector { Faker::Company.industry }
  end
end