require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  test "request_activation" do
    mail = RequestMailer.request_activation
    assert_equal "Request activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_confirmation" do
    mail = RequestMailer.request_confirmation
    assert_equal "Request confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
