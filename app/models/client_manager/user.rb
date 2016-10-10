require 'securerandom'

module ClientManager
  class User < ApplicationRecord
    has_secure_password

    default_scope { order('created_at DESC') }
    validates :name, :email, presence: true
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_numericality_of :maximum_number_of_clients, allow_nil: true

    before_validation :set_temporary_password, unless: :password_exists?
    before_create :send_registration_email
    has_many :clients, dependent: :destroy

    def client_count
      clients.count
    end

    def self.create_superadmin(name, email, password)
      User.create(name: name, email: email, password: password, superadmin: true, maximum_number_of_clients: nil, password_changed: true)
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
