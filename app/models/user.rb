class User < ApplicationRecord
    validates_presence_of :email, :password, :message => "is empty!"
    validates_length_of :password, :minimum => 8, :message => "is less than 8!"
    validates_uniqueness_of :email, :message => "has been used by other people."
    validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => "format is incorrect"
    before_save :save_name

    def save_name
        if self.name.nil?
            self.name = self.email[0,self.email.index("@")]
        end
    end

end
