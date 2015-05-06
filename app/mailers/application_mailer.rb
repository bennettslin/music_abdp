class ApplicationMailer < ActionMailer::Base
  default from: "admin@music_app.com"
  layout 'mailer'
end
