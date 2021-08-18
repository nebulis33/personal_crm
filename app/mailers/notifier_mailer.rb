class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.upcoming_dates.subject
  #
  def upcoming_dates(user, birthdays, events)
    @user = user
    @greeting = "Hi #{@user.first_name}, here is your weekly rundown."
    @birthdays = birthdays
    @upcoming_events = events

    mail to: "to@example.org"
  end
end
