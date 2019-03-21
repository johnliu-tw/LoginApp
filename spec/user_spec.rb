require 'rails_helper'
describe User, :type => :model do
    before(:each) do
        @user = User.new(:email => "gg@gg.com", :password => "password")
    end
    it "is valid with valid attributes" do
        expect(@user).to be_valid
    end
    it "is invalid with invalid email" do
        @user.email = "notgood"
        expect(@user).to_not be_valid
    end
    it "is invalid with invalid password" do
        @user.password = "111"
        expect(@user).to_not be_valid
    end
    it "is invalid with empty email" do
        @user.email = nil
        expect(@user).to_not be_valid
    end
    it "is invalid with empty password" do
        @user.password = nil
        expect(@user).to_not be_valid
    end
    it "is invalid with not unique email" do
        @user.email = "aa@aa.com"
        expect(@user).to_not be_valid
    end
end