FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:other)  { |n| "category #{n}" }
    sequence(:category)  { |n| "Cat #{n}" }
    sequence(:city)  { |n| "city #{n}" }
    sequence(:address)  { |n| "address #{n}" }
    
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end