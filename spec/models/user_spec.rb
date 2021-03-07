require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(first_name: "Jimmy", last_name: "Test", email: "test@email.net", password: "123456")
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(first_name: "Jimmy", last_name: "Test", email: "", password: "123456")
    expect(user).to_not be_valid
  end

  it "is not valid with an email that is already taken" do
    user = User.create(first_name: "Jimmy", last_name: "Test", email: "taken@email.net", password: "123456")
    user2= User.new(first_name: "Jimmy", last_name: "Test", email: "taken@email.net", password: "123456")
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(first_name: "Jimmy", last_name: "Test", email: "test@email.net", password: "")
    expect(user).to_not be_valid
  end

  it "must have a password of at least 6 characters" do
    user = User.new(first_name: "Jimmy", last_name: "Test", email: "test@email.net", password: "12345")
    expect(user).to_not be_valid
  end

  it "is not valid without a first name" do
    user = User.new(first_name: "", last_name: "Test", email: "test@email.net", password: "123456")
    expect(user).to_not be_valid
  end

  it "is not valid without a last name" do
    user = User.new(first_name: "Jimmy", last_name: "", email: "test@email.net", password: "123456")
    expect(user).to_not be_valid
  end
end
