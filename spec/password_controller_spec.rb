require 'rails_helper'
describe PasswordsController, :type => :controller do
    context "when users go to forget password page" do
        it "could see forget page" do
            get :new
            expect(response.status).to eq(200)
        end
        it "could send reset password requirement with correct email" do
            post :reset_password, :params => {:email => "aa@aa.com"}
            expect(assigns(:user).password).to eq("resetpassword")
        end
        it "couldn't send reset password requirement with incorrect email" do
            post :reset_password, :params => {:email => "test@test.com"}
            expect(flash[:notice]).to eq("This email doesn't exist")
        end
    end

    context "when users click reset passsword link" do
        it "could reset email under correct time and token" do
            get :check_reset_token, :params => {:reset_token => "reset_token"}
            expect(response.status).to eq(302)
        end
        it "couldn't reset email with incorrect token" do
            get :check_reset_token, :params => {:reset_token => "wrong_reset_token"}
            expect(flash[:notice]).to eq("We can't find the user accroding to your token or you have submitted the new reset request, please submit the reset email request again")
        end
        it "couldn't reset email under incorrect time" do
            get :check_reset_token, :params => {:reset_token => "reset_token_incorrect_time"}
            expect(flash[:notice]).to eq("This email is invalid because you need to reset within 6 hours, please submit the reset email request again")
        end
        it "could update password with correct format" do
            post :update, :params => {:id => 1 ,:password => "thisistestpassword"}
            expect(response.status).to eq(302)
        end
        it "couldn't update password with incorrect format" do
            post :update, :params => {:id => 1, :password => "111"}
            expect(response).to render_template(:edit)
        end
    end
end