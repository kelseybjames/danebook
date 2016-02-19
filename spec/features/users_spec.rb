# User should be able to sign up on root page
# User should be able to sign in in the header

# TODO: User should not be able to create new user if already logged in

require 'rails_helper'

feature 'User signup' do
  context 'User is not signed in' do
    before do
      visit(root_path)
    end

    scenario 'User can fill in info and sign up' do
      sign_up
      expect{ click_button('Create User') }.to change(User, :count).by(1)
    end

    scenario "Redirects to user timeline after creation" do
      sign_up
      click_button('Create User')
      user = User.find_by_email('foo@bar.com')
      expect(current_path).to eq(user_posts_path(user))
    end

    scenario "User not created if field left blank" do
      sign_up(email: nil)
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end

    scenario "Can't create user with duplicate email" do
      sign_up
      click_button('Create User')
      log_out
      visit(root_path)
      sign_up
      expect{ click_button('Create User') }.to change(User, :count).by(0)
    end
  end
end

feature 'User sign in' do

  context "User exists" do
    before do
      visit(root_path)
      sign_up
      click_button('Create User')
      log_out
    end

    scenario "User can sign in" do
      sign_in
      click_button('Log in')
      user = User.find_by_email('foo@bar.com')
      expect(current_path).to eq(user_posts_path(user))
    end
  end

  context "User does not exist" do
    scenario "Nonexistent user can't sign in" do
      visit(root_path)
      sign_in
      click_button('Log in')
      expect(current_path).to eq(session_path)
    end
  end
end

feature 'Profile access' do
  context 'User logged in' do
    before do
      visit(root_path)
      sign_up(email: 'bar@foo.com')
      click_button('Create User')
      log_out
      visit(root_path)
      sign_up
      click_button('Create User')
    end

    scenario 'User can access their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_profile_path(user))
      expect(page).to have_content('Words to Live By')
    end

    scenario "User can access other users' profiles" do
      new_user = User.find_by_email('bar@foo.com')
      visit(user_profile_path(new_user))
      expect(page).to have_content('Words to Live By')
    end
  end
end

feature 'Editing profile' do
  context 'User logged in' do
    before do
      visit(root_path)
      sign_up(email: 'bar@foo.com')
      click_button('Create User')
      log_out
      visit(root_path)
      sign_up
      click_button('Create User')
    end

    scenario 'User can see edit button on their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_profile_path(user))
      expect(page).to have_content('Edit your Profile')
    end

    scenario "User can't see edit button on other users' profiles" do
      new_user = User.find_by_email('bar@foo.com')
      visit(user_profile_path(new_user))
      expect(page).not_to have_content('Edit your Profile')
    end

    scenario 'User can edit their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_profile_path(user))
      click_link('Edit your Profile')
      expect(current_path).to eq(edit_user_profile_path(user))
    end
  end
end

feature 'Writing posts' do
  context 'User logged in' do
    before do
      visit(root_path)
      sign_up(email: 'bar@foo.com')
      click_button('Create User')
      log_out
      visit(root_path)
      sign_up
      click_button('Create User')
    end

    scenario 'User can write post on their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_posts_path(user))
      write_post
      click_button('Create Post')
      expect(page).to have_content('This is a test post')
    end

    scenario "User can write post on other users' profiles" do
      new_user = User.find_by_email('foo@bar.com')
      visit(user_posts_path(new_user))
      write_post
      click_button('Create Post')
      expect(page).to have_content('This is a test post')
    end
  end
end

feature 'Like/Unlike posts' do
  context 'User logged in' do
    before do
      visit(root_path)
      sign_up(email: 'bar@foo.com')
      click_button('Create User')
      log_out
      visit(root_path)
      sign_up
      click_button('Create User')
    end

    scenario 'User can like post on their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_posts_path(user))
      write_post
      click_button('Create Post')
      click_link('Like(0)')
      expect(page).to have_content('Unlike(1)')
    end

    scenario 'User can unlike post on their own profile' do
      user = User.find_by_email('foo@bar.com')
      visit(user_posts_path(user))
      write_post
      click_button('Create Post')
      click_link('Like(0)')
      click_link('Unlike(1)')
      expect(page).to have_content('Like(0)')
    end
  end
end