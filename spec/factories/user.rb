FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "User ##{n}" }
    sequence(:email) {|n| "User##{n}@gmail.com" }
    password "password"
    password_confirmation "password"
  end
end
