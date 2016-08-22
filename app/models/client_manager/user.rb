require 'securerandom'

module ClientManager
  class User < ApplicationRecord
    attr_accessor :password

    default_scope { order('created_at DESC') }
    validates :name, :email, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    validates_length_of :password, in: 6..20, allow_blank: true
    before_create :set_temporary_password
    before_create :send_registration_email
    before_save :encrypt_password
    after_save :clear_password

    has_many :clients

    def self.authenticate(email="", login_password="")
      user = User.find_by_email(email)
      if user && user.match_password(login_password)
        return user
      else
        return false
      end
    end


    def client_count
      clients.count
    end

    private

    def set_temporary_password
      self.password = SecureRandom.hex(6)
    end

    def send_registration_email
      RegistrationMailer.registration_email(self).deliver
    end

    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
      end
    end

    def clear_password
      self.password = nil
    end

    def match_password(login_password="")
      encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
    end
  end
end
