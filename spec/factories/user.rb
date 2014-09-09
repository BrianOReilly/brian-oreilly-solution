require 'faker'

FactoryGirl.define do

  factory :user do
    sequence(:id){|n| n}
    sequence(:email){|n| "testuser#{n}@goclio.com" }
    first_name "Test"
    last_name "Person"
    password "testtest"
    password_confirmation "testtest"
    team_id ""
  end
  
  factory :invalid_user, parent: :user do
    sequence(:email){|n| nil }
    first_name "John"
    password "testtest"
    password_confirmation "testtest"
    team_id ""
  end
  
end
