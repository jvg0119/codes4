FactoryGirl.define do
  factory :arail_comment, class: 'Arail::Comment' do
    body "Arail createapp comment"
    association :arail_createapp #nil
  end
end
