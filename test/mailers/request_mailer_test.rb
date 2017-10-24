require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  test "request_activation" do
    request = requests(:claire)
    request.activation_token = Request.new_token
    mail = RequestMailer.request_activation(request)
    assert_equal "The Cowork - Waitlist request activation", mail.subject
    assert_equal [request.email], mail.to
    assert_equal ["no-reply@claire-waitlist.herokuapp.com"], mail.from
    assert_match request.name,               mail.body.encoded
    assert_match request.activation_token,   mail.body.encoded
    assert_match CGI.escape(request.email),  mail.body.encoded
  end

  test "request_confirmation" do
    request = requests(:claire)
    request.confirmation_token = Request.new_token
    request.confirmation_digest = Request.digest(request.confirmation_token)
    request.save
    mail = RequestMailer.request_confirmation(request)
    assert_equal "The Cowork - Waitlist confirmation", mail.subject
    assert_equal [request.email], mail.to
    assert_equal ["no-reply@claire-waitlist.herokuapp.com"], mail.from
    assert_match request.name,               mail.body.encoded
    assert_match request.confirmation_token,   mail.body.encoded
    assert_match CGI.escape(request.email),  mail.body.encoded
  end

end
