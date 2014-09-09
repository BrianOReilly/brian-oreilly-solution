require 'faker'

FactoryGirl.define do
  
  factory :team do
    name Faker::Name.name
  end
  
  factory :invalid_team, parent: :team do
    name nil
  end

end