FactoryGirl.define do
  factory :user, aliases: [:liking_user, :friended_users, :users_friended_by, :friend_initiator, :friend_recipient, :author] do
    sequence(:email){ |n| "foo#{n}@bar.com" }
    password "test"
  end
end