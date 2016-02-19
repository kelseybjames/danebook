require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }

  describe 'POST #create' do
    let(:post_create_user) do
      post :create, user: attributes_for(
            :user,
            email: 'foo@bar.com',
            password: 'foobar')
    end

    let(:post_create_invalid) do
      post :create, user: attributes_for(
            :user,
            email: '',
            password: '')
    end

    it 'creates a new user' do
      expect{ post_create_user }.to change(User, :count).by(1)
    end

    it 'does not create user if params are invalid' do
      expect{ post_create_invalid }.to change(User, :count).by(0)
    end
  end
end