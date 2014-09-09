class Membership < ActiveRecord::Base
  attr_accessible :team_id, :user_id
  belongs_to :team
  belongs_to :user
  sync :all
  
  scope :with_user, lambda {|user| where("user_id = :id", :id => user.id) }
  scope :with_team, lambda {|team| where("team_id = :id", :id => team.id) }
end
