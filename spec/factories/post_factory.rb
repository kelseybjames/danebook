FactoryGirl.define do
  factory :post do
    body "This is a test post."
    user
  end
end