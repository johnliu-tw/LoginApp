class ContactMailer < ApplicationMailer
    layout 'mailer'

    def welcome_email(email)
        @contact = {}
        @contact[:message] = "Hello, welcome to Login App"
        mail(to: email, subject: 'Welcome to Login App',:template_name => "email_template")
    end

    def reset_email(email, token, request)
        url = request.host+"/passwords/reset_password?reset_token=" + token
        @contact = {}
        @contact[:message] = "Hello, your reset url is <a href='#{url}'>#{url}</a>"
        mail(to: email, subject: 'Reset your password',:template_name => "email_template")        
    end
end