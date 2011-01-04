class Notifier < ActionMailer::Base
  

  def gmail_message(user)
    subject    'Message via Gmail'
    recipients  user.email
    from       'zorooking22@gmail.com'
    sent_on    Time.now
    
    body       :user=>user
  end

end
