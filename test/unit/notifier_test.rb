require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "gmail_message" do
    @expected.subject = 'Notifier#gmail_message'
    @expected.body    = read_fixture('gmail_message')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_gmail_message(@expected.date).encoded
  end

end
