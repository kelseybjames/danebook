# User should be able to sign up on root page
# User should be able to sign in in the header

require 'rails_helper'

feature 'User signup' do
  context 'User is not signed in' do
    before do
      visit(root_path)
    end

    scenario 'User can fill in info and sign up' do
      sign_up_form
      save_and_open_page
      expect{ click_button('Create User') }.to change(User, :count).by(1)
    end

    scenario "Redirects to user timeline after creation" do
      sign_up_form
      click_button('Create User')
      user = User.find_by_email('foo@bar.com')
      expect(current_path).to eq(user_posts_path(user))
    end
  end

end