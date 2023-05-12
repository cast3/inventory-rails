module Onboardable
  extend ActiveSupport::Concern

  included do
    after_create :send_welcome_email
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end
end

