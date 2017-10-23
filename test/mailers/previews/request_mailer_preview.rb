# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_activation
  def request_activation
    RequestMailer.request_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_confirmation
  def request_confirmation
    RequestMailer.request_confirmation
  end

end
