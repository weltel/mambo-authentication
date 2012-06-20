# -*- encoding : utf-8 -*-
require "spec_helper"

describe Authentication::User do
	#
	it "creates a valid user" do
		params = attributes_for(:user)

		user = Authentication::User.create(params)

		user.should be_valid
	end

	#
	it "finds a user with good credentials" do
		create(:user)

		credentials = build(:credentials)

		user = Authentication::User.first_by_credentials(credentials)

		user.should_not be_nil
	end

  #
  it "doesn't find a user with bad credentials" do
    create(:user)

    credentials = build(:credentials, :password => "bad")

    user = Authentication::User::first_by_credentials(credentials)

    user.should be_nil

    credentials = build(:credentials, :email_address => "bad@bad.bad")

    user = Authentication::User::first_by_credentials(credentials)

    user.should be_nil
  end

	#
  it "sorts by" do
  	Authentication::User.sorted_by(:name, :asc)
  end

	#
	it "filters by phone number" do
  	phone_number = "2222222222"

  	user = create(:user, :phone_number => phone_number)

  	Authentication::User.with_phone_number
  end

	#
  it "creates by params" do
		params = attributes_for(:user)

		user = Authentication::User.create_by(params)

		user.should be_valid
  end

	#
  it "updates by id" do
  	phone_number = "9999999999"
		user = create(:user)

		user = Authentication::User.update_by_id(user.id, :phone_number => phone_number)

		user.should be_valid
		user.phone_number.should == phone_number
  end

	#
  it "destroys by id" do
  	user = create(:user)

  	Authentication::User.destroy_by_id(user.id)
  end
end
