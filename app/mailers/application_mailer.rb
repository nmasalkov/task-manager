# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'nikita.duplan@gmail.com'
  layout 'mailer'
end
