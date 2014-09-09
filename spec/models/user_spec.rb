require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:team) { create(:team) }

  describe "#status=" do
    before do
      user.status = status
    end

    context "when given an accepted enum value" do
      let(:status) { :in }
      it "writes the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[status]
      end
    end
    
    context "when given an accepted num value for in" do
      let(:status) { 1 }
      it "writes the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[:in]
      end
    end
    
    context "when given an accepted num value for out" do
      let(:status) { 0 }
      it "writes the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[:out]
      end
    end

    context "when given an unacceptable value" do
      let(:status) { :bad_status }
      it "writes nil in the database" do
        expect(user.send(:read_attribute, :status)).to be_nil
      end
    end

  end
  
  describe "#team_id=" do
    before do
      user.team_id = team_id
    end

    context "when given a blank team ID" do
      let(:team_id) { "" }
      it "returns nil for team id" do
        expect(user.team_id.nil?)
      end
    end
    
    context "when given a valid team ID" do
      let(:team_id) { team.id }
      it "returns nil for team id" do
        expect(user.team_id.should == team.id)
      end
    end
  
  end
  
  describe "full_name" do
    it "returns a contact's full name as a string" do 
      user = create(:user, first_name: "John", last_name: "Doe") 
      user.full_name.should == "John Doe" 
    end 
  end
  
  describe "#current_sign_in_ip=" do
    before do
      user.current_sign_in_ip = current_sign_in_ip
      user.save
    end

    context "when new current_sing_in_ip is valid ip" do
      let(:current_sign_in_ip) { "10.138.116.1" } 
      it "returns value for ip" do
        expect(user.current_sign_in_ip.should == "10.138.116.1" )
      end
    end
    
    context "when new current_sing_in_ip is not valid ip" do
      let(:current_sign_in_ip) { "10.138.116" } 
      it "returns value for ip" do
        expect(user.current_sign_in_ip.should == nil )
      end
    end
    
  
  end

end
