require "rails_helper"

RSpec.describe NotifierMailer, type: :mailer do
  describe "upcoming_dates" do
    let(:mail) { NotifierMailer.upcoming_dates }

    it "renders the headers" do
      expect(mail.subject).to eq("Upcoming dates")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
