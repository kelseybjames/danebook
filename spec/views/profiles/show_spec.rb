require 'rails_helper'

describe 'profiles/show.html.erb' do
  let(:user){ create(:user) }
  let(:profile){ create(:profile, user: user) }

  before do
    user
    profile

    def view.current_user
      @user
    end
  end

  context 'user logged in' do
    before do
      def view.signed_in_user?
        true
      end
    end

    it 'profile visible to logged in user' do
      assign(:user, user)
      assign(:profile, profile)
      render
      expect(rendered).to match("#{user.profile.quote}")
    end

    it 'profile edit button viewable to current user' do
      assign(:user, user)
      assign(:profile, profile)
      render
      expect(rendered).to match("Edit your Profile")
    end
  end
end