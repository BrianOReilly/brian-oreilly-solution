require 'spec_helper'

describe UsersController do

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
    it "assigns the requested user to @user" do 
      user = create(:user) 
      get :show, id: user 
      assigns(:user).should == (user) 
    end 
    
    it "renders the #show view" do 
      get :show, id: create(:user) 
      response.should render_template :show 
    end 
  end
  
  describe "GET status" do
    before :each do 
      @user = create(:user, status: :in) 
    end
    it "returns the users status" do 
      user = create(:user, status: :in) 
      get :status, id: user 
      assigns(:user).status.should == (@user.status) 
    end     
  end
  
  describe "POST new" do 
    context "with valid attributes" do
      before { sign_out user } 
      it "creates a new user" do 
        expect{ 
          post :new, user: create(:user) 
          }.to change(User,:count).by(1) 
      end 
      
      before { sign_in user } 
      it "redirects to the users list" do 
        post :new, user: create(:user) 
        response.should redirect_to users_path 
      end 
    end
  end 
  
  describe "PUT edit" do
    before :each do 
      @user = create(:user, first_name: "Lawrence", last_name: "Smith") 
    end
    
    it "assigns user to @user" do 
      put :edit, id: @user 
      assigns(:user).should == (@user) 
    end
  end
  
  describe "PUT update" do
    before :each do 
      @user = create(:user, first_name: "Lawrence", last_name: "Smith", email: "juststring@goclio.com") 
    end
    
    context "valid attributes" do
      it "located the requested @user" do 
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/users/' + user.id.to_s + '/edit'
        put :update, id: @user, user: attributes_for(:user, first_name: "Lawrence", last_name: "Smith")
        assigns(:user).should == @user
      end
      
      it "changes @user's attributes" do 
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/users/' + user.id.to_s + '/edit'
        put :update, id: @user, user: attributes_for(:user, first_name: "John", last_name: "Doe") 
        @user.reload 
        @user.first_name.should eq("John") 
        @user.last_name.should eq("Doe") 
      end 
      
      it "redirects to users_path when user url is passed" do 
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/users/' + user.id.to_s + '/edit'
        put :update, id: @user, user: attributes_for(:user, first_name: "John", last_name: "Doe") 
        response.should redirect_to users_path
      end 
    end
    
    context "invalid attributes" do
      it "re-renders the edit method" do 
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/users/' + user.id.to_s + '/edit'
        put :update, id: @user, user: attributes_for(:invalid_user) 
        response.should redirect_to users_path 
      end 
    end
  end
  
  describe 'DELETE destroy' do 
    before :each do 
      @user = create(:user) 
    end 
    
    it "deletes the user" do 
      expect{ 
        delete :destroy, id: @user 
      }.to change(User,:count).by(-1) 
    end 
    
    it "redirects to users_path" do 
      delete :destroy, id: @user 
      response.should redirect_to users_path
    end 
  end
  
end
