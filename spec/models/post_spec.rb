# Test that post is created with valid user, body

require 'rails_helper'

describe Post do

  let(:post){ build(:post) }

  describe 'attributes' do
    it 'default post is valid' do
      expect(post).to be_valid
    end

    it 'invalid if body is nil' do
      new_post = build(:post, body: nil)
      expect(new_post).not_to be_valid
    end

    it 'invalid if user is nil' do
      new_post = build(:post, user: nil)
      expect(new_post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(post).to respond_to(:user)
    end

    it 'has many comments' do
      expect(post).to respond_to(:comments)
    end

    it 'has many post_likings' do
      expect(post).to respond_to(:post_likings)
    end

    it 'has many liking_users' do
      expect(post).to respond_to(:liking_users)
    end
  end
end