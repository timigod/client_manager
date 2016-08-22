module ClientManager
  class ApplicationMailer < ActionMailer::Base
    default from: 'client-manager@example.com'
    layout 'mailer'
  end
end
