# Test that profile is created with valid user
# Set quote, about_me, first_name, last_name, day, month, year, gender

require 'rails_helper'

describe Profile do

  let(:user){ build(:user) }
  let(:profile){ build(:profile) }

  describe 'attributes' do
    it 'has valid attributes' do
      expect(profile).to be_valid
    end

    it 'saves with valid attributes' do
      expect{ profile.save! }.not_to raise_error
    end

    it 'is not valid with blank first name' do
      new_profile = build(:profile, first_name: "")
      expect(new_profile).not_to be_valid
    end

    it 'is not valid with blank last name' do
      new_profile = build(:profile, last_name: "")
      expect(new_profile).not_to be_valid
    end

    it 'needs gender to be valid' do
      new_profile = build(:profile, gender: 'asdf')
      expect(new_profile).not_to be_valid
    end

    it 'needs user to be valid' do
      new_profile = build(:profile, user: nil)
      expect(new_profile).not_to be_valid
    end

    it 'is valid with given user' do
      new_profile = build(:profile, user: user)
      expect(new_profile).to be_valid
    end

    it 'can have blank quote' do
      new_profile = build(:profile, quote: "")
      expect(new_profile).to be_valid
    end

    it 'can have blank about_me' do
      new_profile = build(:profile, about_me: "")
      expect(new_profile).to be_valid
    end

    it 'needs valid day' do
      new_profile = build(:profile, day: 0)
      expect(new_profile).not_to be_valid
    end

    it 'needs valid month' do
      new_profile = build(:profile, month: 0)
      expect(new_profile).not_to be_valid
    end

    it 'needs valid year' do
      new_profile = build(:profile, year: 0)
      expect(new_profile).not_to be_valid
    end

    it 'invalid with quote 141 characters long' do
      new_profile = build(:profile, quote: 'A' * 141)
      expect(new_profile).not_to be_valid
    end

    it 'invalid with about_me 1001 characters long' do
      new_profile = build(:profile, about_me: 'A' * 1001)
      expect(new_profile).not_to be_valid
    end

  end

  describe 'associations' do
    it 'responds to user' do
      expect(profile).to respond_to(:user)
    end
  end
end