require 'rails_helper'
describe UsersController, :type => :controller do
    context "when user havn't signed up" do
        it "could see index page" do
            get :index
            expect(response.status).to eq(200)
        end
        it "could see sign up page" do
            get :new
            expect(response.status).to eq(200)
        end
        
        it "could create account with correct format data" do
            post :create, :params => { :email => "test@test.com", :password => "password" }
            expect(response.status).to eq(302)
        end
        it "couldn't create account with incorrect format data" do
            post :create, :params => { :email => "test@test.com", :password => "pass" }
            expect(response).to render_template(:new)
        end
        it "couldn't go through user's page" do
            get :show, :params => {:id => 1}
            get :edit, :params => {:id => 1}
            post :update, :params => { :id => 1, :name => "TestName", :password => "22222222" }
            expect(response.status).to eq(302)
        end
    end

    context "when user has signed up" do
        it "could login with correct account" do
            post :login, :params => { :email => "aa@aa.com", :password => "resetpassword" }
            expect(session[:user]).to eq(assigns(:user)["id"])
        end
        it "couldn't login with incorrect password" do
            post :login, :params => { :email => "aa@aa.com", :password => "11111111" }
            expect(flash[:notice]).to eq("The email or password is incorrect")
        end  
        it "couldn't login with incorrect email" do
            post :login, :params => { :email => "aaa@aa.com", :password => "resetpassword" }
            expect(flash[:notice]).to eq("The email or password is incorrect")
        end  
    end

    context "when user has logged in" do
        before(:each) do
            post :login, :params => { :email => "aa@aa.com", :password => "resetpassword" }
            expect(session[:user]).to eq(assigns(:user)["id"])
        end
        it "could log out" do
            post :logout
            expect(session[:user]).to eq(nil)
        end
        it "could check it's page" do
            get :show, :params => {:id => session[:user]}
            expect(response).to render_template(:show)
        end       
        it "could check edit infomation page" do
            get :edit, :params => {:id => session[:user]}
            expect(response).to render_template(:edit)
        end    
        it "could update it's data with correct format" do
            get :update, :params => { :id => session[:user], :name => "TestName", :password => "22222222" }
            expect(response.status).to eq(302)
        end      
        it "couldn't update it's data with incorrect format" do
            get :update, :params => { :id => session[:user], :name => "TestName", :password => "22222" }
            expect(response).to render_template(:edit)
        end           
    end 
end