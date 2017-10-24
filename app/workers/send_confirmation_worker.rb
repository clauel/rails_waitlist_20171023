class SendConfirmationWorker
  include Sidekiq::Worker

  def perform(request_id)
    request = Request.find(request_id)
    request.send_confirmation_email
  end
end
