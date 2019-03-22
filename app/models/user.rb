class User < ApplicationRecord
    validates_presence_of :email, :password, :message => "is empty!"
    validates_length_of :password, :minimum => 8, :message => "is less than 8!"
    validates_uniqueness_of :email, :message => "has been used by other people."
    validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => "format is incorrect"
    before_save :save_name

    include BCrypt

    def password_hash
        @password ||= BCrypt::Password.new(password)
    end

    def password_hash=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password = @password
    end

    private 
    def save_name
      if self.name.nil?
        self.name = email[0,email.index("@")]
      end
    end

end
