class Team < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  has_many :memberships
  has_many :users, :through => :memberships
  sync :all
  
  scope :with_user, lambda {|user| where("user_id = :id", :id => user.id) }
end
