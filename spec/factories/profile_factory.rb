FactoryGirl.define do
  factory :profile do
    sequence(:first_name){ |n| "Foo#{n}" }
    sequence(:last_name){ |n| "Bar#{n}" }
    quote    "This is a test quote"
    about_me "This is where you learn about me"
    day      12
    month    8
    year     1993
    gender   "Female"
    user
  end
end