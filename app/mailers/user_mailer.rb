class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "welcome to #{ENV['COMPANY_NAME']}!")
  end

  def offer_setup_assistance(user)
    @user = user
    mail(to: user.email, subject: 'can we help you get set up?')
  end
end
