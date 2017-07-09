FactoryGirl.define do
  factory :user do # signed regular user
    name "John"
    sequence(:email, 1) { |n| "#{name.gsub(/ /,'').downcase}#{n}@example.com" }
    password 'password'
  end
end
