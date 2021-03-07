require 'rails_helper'

RSpec.describe Contact, type: :model do
  User.create(first_name: "Jimmy", last_name: "Test", email: "testing@email.net", password: "123456")
  user = User.first
  user.confirm

  it "is valid with valid parameters" do
    contact = Contact.new(user_id: User.first.id, first_name: "Jane", last_name: "Test", nickname: "JD", email: "test@email.com",
    phone_number: "1234567", address: "1 Washington St, San Francisco, CA, 94002", birthday: 2.years.ago)
    expect(contact).to be_valid
  end

  it "is not valid without a user id" do
    contact = Contact.new(user_id: '', first_name: "Jane", last_name: "Test", nickname: "JD", email: "test@email.com",
    phone_number: "1234567", address: "1 Washington St, San Francisco, CA, 94002", birthday: 2.years.ago)
    expect(contact).to_not be_valid
  end

  it "is not valid without a first name" do
    contact = Contact.new(user_id: User.first.id, first_name: "", last_name: "Test", nickname: "JD", email: "test@email.com",
    phone_number: "1234567", address: "1 Washington St, San Francisco, CA, 94002", birthday: 2.years.ago)
    expect(contact).to_not be_valid
  end

  it "is valid with only user id and first name" do
    contact = Contact.new(user_id: User.first.id, first_name: "Jane", last_name: "", nickname: "", email: "",
    phone_number: "", address: "", birthday: "")
    expect(contact).to be_valid
  end
end
