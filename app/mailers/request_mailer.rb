class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.request_activation.subject
  #
  def request_activation(request)
    @request = request
    mail to: request.email, subject: "Waitlist request activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.request_confirmation.subject
  #
  def request_confirmation(request)
    @request = request
    mail to: request.email, subject: "Waitlist confirmation"
  end
end
