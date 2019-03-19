class ContactMailer < ApplicationMailer
    layout 'mailer'

    def welcome_email(email)
        @contact = {}
        @contact[:message] = "Hello, welcome to Login App"
        mail(to: email, subject: 'Welcome to Login App',:template_name => "welcome")
    end
end