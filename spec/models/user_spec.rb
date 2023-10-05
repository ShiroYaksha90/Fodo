require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: "John Doe", email: "john@example.com")
  end

  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end

  it "is not valid without a username" do
    @user.name = nil
    expect(@user).to_not be_valid
  end 

  it "is not valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it "is not valid with a username longer than 50 characters" do
    @user.name = "a" * 51
    expect(@user).to_not be_valid
  end

  it "is not valid with an email longer than 255 characters" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).to_not be_valid
  end
  it "is valid with a valid email address" do
    valid_addresses = %w[ user@example.com BASIM@gmail.com B.first@yahoo.ca john+smith@co.uk.org ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end
  it "is not valid with an invalid email address" do
  invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com ]
  invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
  end
end
  it "is not valid with a duplicate email address" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end
  it "Email addresses be lwercase before hitting the database" do
    mixed_case_email = "JoHn@gmail.com"
    @user.email = mixed_case_email
    @user.save
    expect(@user.reload.email).to eq mixed_case_email.downcase
  end
end
