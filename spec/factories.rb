FactoryBot.define do
  factory :transaction do
    description { "Salary" }
    amount { "1000.00" }
    category { :general }
  end
end
