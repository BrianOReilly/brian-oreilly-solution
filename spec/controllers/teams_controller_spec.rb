require 'spec_helper'

describe TeamsController do
  let(:team) { create(:team) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end
 
  describe "GET index" do
    before { get :index }
    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end 
  
  describe "GET show" do
    it "assigns the requested team to @team" do 
      team = create(:team) 
      get :show, id: team 
      assigns(:team).should == (team) 
    end 
    
    it "renders the #show view" do 
      get :show, id: create(:team) 
      response.should render_template :show 
    end 
  end
  
  describe "POST new" do 
    context "with valid attributes" do
      it "creates a new team" do 
        expect{ 
          post :new, team: create(:team) 
          }.to change(Team,:count).by(1) 
      end 
      
    end
  end 
  
  describe "PUT edit" do
    before :each do 
      @team = create(:team, name: "DummyTeam") 
      @user_a = create(:user)
      @user_b = create(:user)
      @team.users << @user_a
      @team.users << @user_b
      @team.reload
      @users = User.all
      @memberships = Membership.all
    end
    
    it "assigns team to @team" do 
      put :edit, id: @team 
      assigns(:team).should == (@team) 
    end
    
    it "assigns all users to @users" do 
      put :edit, id: @team 
      assigns(:users).should == (@users) 
    end
    
    it "assigns team.memberships to @memberships" do 
      put :edit, id: @team 
      assigns(:memberships).should == (@memberships) 
    end
    
  end
  
  describe "POST create" do 
    context "with valid attributes" do 
      it "creates a new team" do 
        expect{ 
          post :create, team: attributes_for(:team) 
        }.to change(Team,:count).by(1) 
      end 
      
      it "redirects to the new team" do 
        post :create, team: attributes_for(:team) 
        response.should redirect_to teams_path 
      end 
    end 
    
    context "with invalid attributes" do 
      it "does not save the new team" do 
        expect{ 
          post :create, team: attributes_for(:invalid_team) 
        }.to_not change(Team,:count) 
      end 
      
      it "re-renders the new method" do 
        post :create, team: attributes_for(:invalid_team) 
        response.should render_template :new 
      end 
    end 
  end 
  
  
  describe "PUT update" do
    before :each do 
      @team = create(:team, name: "TestTeam") 
    end
    
    context "valid attributes" do
      it "located the requested @team" do 
        put :update, id: @team, team: attributes_for(:team, name: "TestTeam")
        assigns(:team).should == @team
      end
      
      it "changes @team's attributes" do 
        put :update, id: @team, team: attributes_for(:team, name: "OtherTeam") 
        @team.reload 
        @team.name.should eq("OtherTeam") 
      end 
      
      it "redirects to teams_path when updated" do 
        put :update, id: @team, team: attributes_for(:team, name: "OtherTeam") 
        response.should redirect_to teams_path
      end 
    end
    
    context "invalid attributes" do
      it "re-renders the edit method" do 
        put :update, id: @team, team: attributes_for(:invalid_team) 
        response.should redirect_to teams_path 
      end 
    end
  end
  
  describe 'DELETE destroy' do 
    before :each do 
      @team = create(:team) 
    end 
    
    it "deletes the team" do 
      expect{ 
        delete :destroy, id: @team 
      }.to change(Team,:count).by(-1) 
    end 
    
    it "redirects to teams_path" do 
      delete :destroy, id: @team 
      response.should redirect_to teams_path
    end 
  end
end
