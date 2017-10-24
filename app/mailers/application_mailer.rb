class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@claire-waitlist.herokuapp.com"
  layout 'mailer'
end
