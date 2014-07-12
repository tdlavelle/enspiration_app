FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :question do
    content "Lorem ipsum?"
    user
  end

  factory :response do
    content "Lorem!"
    question
  end
end