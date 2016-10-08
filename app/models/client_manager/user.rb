require 'securerandom'

module ClientManager
  class User < ApplicationRecord
    has_secure_password

    default_scope { order('created_at DESC') }
    validates :name, :email, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    before_validation :set_temporary_password, unless: :password_exists?
    before_create :send_registration_email
    has_many :clients

    def client_count
      clients.count
    end

    private


    def password_exists?
      !self.password_digest.blank?
    end

    def set_temporary_password
      self.password = SecureRandom.hex(6)
    end

    def send_registration_email
      RegistrationMailer.registration_email(self).deliver
    end


  end
end
