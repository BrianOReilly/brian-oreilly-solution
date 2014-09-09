10.times do |n|
  User.create(:email => "user#{n}@goclio.com", 
              :first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name,
              :password => "testtest",
              :password_confirmation => "testtest", 
              :status => :out)
              
end

Team.create(:name => "Customer Service")
Team.create(:name => "Salespeople")

Membership.create(:user_id => 3, :team_id => 1)
Membership.create(:user_id => 4, :team_id => 1)
Membership.create(:user_id => 6, :team_id => 2)
Membership.create(:user_id => 8, :team_id => 2)
Membership.create(:user_id => 9, :team_id => 2)
