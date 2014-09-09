require 'spec_helper'

describe ApplicationHelper do
  let(:user) { create(:user) }
  
  describe "name_with_status" do
    it "returns a users name along with their sign in status" do 
      @user = create(:user, first_name: "John", last_name: "Doe") 
      name_with_status(@user.full_name,@user.status,@user.id).should == link_to(@user.full_name, user_path(@user.id), :class => "name") +
                                                                        content_tag(:span, @user.status, :class => "status status-#{@user.status}") +
                                                                        link_to("Update", status_user_path(@user.id), :class => "update-link")
    end 
  end
end