# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier/upcoming_dates
  def upcoming_dates
    NotifierMailer.upcoming_dates(User.first, User.first.birthdays, Event.includes(:contact).where(user_id: User.first.id).upcoming_events)
  end

end
