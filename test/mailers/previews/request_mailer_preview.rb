# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_activation
  def request_activation
    request = Request.first
    request.activation_token = Request.new_token
    RequestMailer.request_activation(request)
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_confirmation
  def request_confirmation
    request = Request.first
    request.confirmation_token = Request.new_token
    RequestMailer.request_confirmation(request)
  end

end
