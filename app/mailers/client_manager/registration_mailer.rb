module ClientManager
  class RegistrationMailer < ApplicationMailer


    def registration_email(user)
      @user = user
      @application_name = ::Rails.application.class.parent.name
      @url = ClientManager::Engine.routes.url_helpers.login_path
      mail(to: @user.email, subject: "You have been added to #{@application_name}'s ClientManager'")
    end
  end
end
