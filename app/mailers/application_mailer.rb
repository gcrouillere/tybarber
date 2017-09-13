class ApplicationMailer < ActionMailer::Base
  default from: 'contact@'+ENV['APPNAME']+'.com'
  layout 'mailer'
end
