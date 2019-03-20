class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :check_login, only: [:show, :edit, :update, :logout]
    def index

    end

    def new
        @user = User.new()
    end

    def create 
        @user = User.new(email: params[:email], password: params[:password])
        respond_to do |format|
            if @user.save
              session[:user] = @user
              ContactMailer.welcome_email(@user.email).deliver
              format.html { redirect_to @user }
            else
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
    end

    def edit
    end

    def update
       respond_to do |format|
        if @user.update(name: params[:name], password: params[:password])
            format.html { redirect_to @user}
        else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
       end
    end

    def login
        @user = User.find_by(email: params[:email])
        if @user
            @user = User.find_by(email: params[:email], password: params[:password])
            if @user
                session[:user] = @user
                redirect_to @user
            else
                redirect_to root_path, notice: "This password is incorrect"
            end
        else
            redirect_to root_path, notice: "This email doesn't exist"
        end


    end

    def logout
        session[:user] = nil
        redirect_to root_path
    end

    def set_user
        @user = User.find(params[:id])
    end

    def check_login
        if session[:user] == nil
            redirect_to root_path
        end
    end
end