class PasswordsController < ApplicationController

    def new
    end

    def edit
        @user = User.find_by(id: session[:user]["id"])
    end

    def update
        @user = User.find_by(id: params[:id])

        respond_to do |format|
            if @user.update(password: params[:password])
                format.html { redirect_to @user}
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def reset_password
        @user = User.find_by(email: params[:email])
        if @user 
            @user.password = "resetpassword"
            @user.reset_sent_at = Time.now

            crypt = ActiveSupport::MessageEncryptor.new("thisisanencryptorkeyforlogin-app")
            encrypted_token = crypt.encrypt_and_sign(@user.id.to_s+Time.now.to_s)
            @user.reset_token = encrypted_token
            if @user.save
                ContactMailer.reset_email(@user.email, @user.reset_token, request).deliver
                flash[:notice] = "The reset password email has been sent, please check your email box"
                render :new
            else 
                flash[:notice] = "The data has some issues"
                render :new                
            end
        else
            flash[:notice] = "This email doesn't exist"
            render :new
        end
    end

    def check_reset_token
        token = params[:reset_token]
        @user = User.find_by(reset_token: token)

        if @user.present?
            if Time.now - 6.hours >= @user.reset_sent_at
                flash[:notice] = "This email is invalid because you need to reset within 6 hours, please submit the reset email request again" 
                render :new
            else
                session[:user] = @user
                redirect_to '/passwords/edit'
            end
        else 
            flash[:notice] = "We can't find the user accroding to your token or you have submitted the new reset request, please submit the reset email request again"
            render :new
        end
    end


end