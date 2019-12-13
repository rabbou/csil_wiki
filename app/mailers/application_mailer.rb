class ApplicationMailer < ActionMailer::Base
  default from: "me@MYDOMAIN.com"
  layout 'mailer'

  def new_record_notificatioin(record)
    @record = record
    mail to: "traclin@uchicago.edu", subject: "Success! You did it."
  end
end
