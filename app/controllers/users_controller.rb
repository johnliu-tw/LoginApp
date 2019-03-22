class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :check_login, only: [:show, :edit, :update, :logout]
    def index
        @user = User.find_by(id: session[:user])
    end

    def new
        @user = User.new()
    end

    def create 
        @user = User.new(email: params[:email], password: params[:password])
        if @user.invalid?
            render :new
        else
            @user.password_hash = params[:password]
            respond_to do |format|
            if @user.save
                  session[:user] = @user.id
                  ContactMailer.welcome_email(@user.email).deliver
                  format.html { redirect_to @user }
                else
                  format.html { render :new }
                end
            end
        end
    end

    def show
    end

    def edit
    end

    def update
      @user.password = params[:password]
      if @user.invalid?
        render :edit
      else
        @user.password_hash = params[:password]
        respond_to do |format|
            if @user.update(name: params[:name])
                format.html { redirect_to @user}
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
      end
    end

    def login
        @user = User.find_by(email: params[:email])
        
        if @user and @user.password_hash == params[:password]
                session[:user] = @user.id
                redirect_to @user
        else
            flash[:notice] = "The email or password is incorrect"
            redirect_to root_path
        end


    end

    def logout
        session[:user] = nil
        redirect_to root_path
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def check_login
        if session[:user] == nil
            redirect_to root_path
        end
    end
end