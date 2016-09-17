require 'securerandom'

module ClientManager
  class User < ApplicationRecord
    has_secure_password

    default_scope { order('created_at DESC') }
    validates :name, :email, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    # validates_length_of :password, in: 6..20, allow_blank: true
    before_validation :set_temporary_password, unless: :password_exists?
    before_create :send_registration_email
    # before_save :encrypt_password
    # after_save :clear_password

    has_many :clients

    # def self.authenticate(email="", login_password="")
    #   user = User.find_by_email(email)
    #   if user && user.match_password(login_password)
    #     return user
    #   else
    #     return false
    #   end
    # end

    # def match_password(login_password="")
    #   BCrypt::Password.new(self.password) == login_password
    # end

    def client_count
      clients.count
    end

    private


    def password_exists?
      !self.password_digest.blank?
    end

    def set_temporary_password
      self.password = SecureRandom.hex(6)
      puts "being called"
    end

    def send_registration_email
      RegistrationMailer.registration_email(self).deliver
    end

    # def encrypt_password
    #   if password.present?
    #     self.encrypted_password = BCrypt::Password.create(password)
    #     puts "encrypt being called"
    #   end
    # end

    # def clear_password
    #   self.password = nil
    # end
  end
end
