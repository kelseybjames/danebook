require 'rails_helper'

describe ProfilesController do
  let(:user){ create(:user) }
  let(:profile){ create(:profile, user: user) }

  describe 'PUT #update' do
    let(:put_update_profile) do
      put :update,
            user_id: user.id,
            profile: attributes_for(
            :profile,
            quote: 'I am a strange loop',
            about_me: 'I am a cool cat')
    end

    let(:put_update_invalid) do
      put :update,
            user_id: user.id,
            profile: attributes_for(
            :profile,
            first_name: '',
            last_name: '')
    end

    context 'user signed in' do
      before do
        user
        profile
        create_session(user)
      end

      it 'profile updated if user signed in' do
        put_update_profile
        profile.reload
        expect(user.profile.quote).to eq('I am a strange loop')
      end

      it 'profile not updated if invalid params' do
        put_update_invalid
        profile.reload
        expect(user.profile.first_name).not_to eq("")
      end
    end

    context 'user not signed in' do
      before do
        user
        profile
      end

      it 'profile not updated if user signed out' do
        put_update_profile
        profile.reload
        expect(user.profile.quote).not_to eq('I am a strange loop')
      end
    end
  end

  describe 'GET #show' do
    before do
      user
      profile
      create_session(user)
    end

    it "shows user's profile" do
      get :show, { user_id: user.id }
      expect(assigns(:profile)).to eq(profile)
    end
  end
end