# Test that user is created with valid email,password
# Test that user is not created when parameters are invalid
# Test that user is not created when parameters are not provided
# Test that user responds to :profile, :posts, :post_likings, :liked_posts, :comments, :initiated_friendings, :friended_users, :received_friendings, :users_friended_by
# Test that we can't create a user with a duplicate email address

require 'rails_helper'

describe User do

  let(:user){ build(:user) }

  describe 'attributes' do
    it 'has valid attributes' do
      expect(user).to be_valid
    end

    it 'saves with valid attributes' do
      expect{ user.save! }.not_to raise_error
    end

    it 'is not valid if email is blank' do
      new_user = build(:user, email: "")
      expect(new_user).not_to be_valid
    end

    it 'is not valid if password is blank' do
      new_user = build(:user, password: "")
      expect(new_user).not_to be_valid
    end

    it 'is valid with an 8 character email' do
      new_user = build(:user, email: "fo@b.com")
      expect(new_user).to be_valid
    end

    it 'is valid with a 48 character email' do
      new_user = build(:user, email: "foo.longemailfortestingpurpostssssssssss@bar.com")
      expect(new_user).to be_valid
    end

    it 'is invalid with a 49 character email' do
      new_user = build(:user, email: "foo.longemailfortestingpurpostsssssssssss@bar.com")
      expect(new_user).not_to be_valid
    end

    context "a user is already saved" do
      before do
        test_user = build(:user, email: 'foo@bar.com')
        test_user.save!
      end

      it 'is invalid with an email which is already taken' do
        new_user = build(:user, email: "foo@bar.com")
        expect(new_user).not_to be_valid
      end
    end

    it "is invalid with a 3 letter password" do
      new_user = build(:user, password: "foo")
      expect(new_user).not_to be_valid
      expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "is valid with a 24 letter password" do
      new_user = build(:user, password: "foobarfoobarfoobarfoobar")
      expect(user).to be_valid
    end

    it "is invalid with a 25 letter password" do
      new_user = build(:user, password: "foobarfoobarfoobarfoobarf")
      expect(new_user).not_to be_valid
      expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "associations" do
    before do
      user.save!
    end

    it "responds to :profile" do
      expect(user).to respond_to(:profile)
    end

    it "responds to :posts" do
      expect(user).to respond_to(:posts)
    end

    it "responds to :post_likings" do
      expect(user).to respond_to(:post_likings)
    end

    it "responds to :liked_posts" do
      expect(user).to respond_to(:liked_posts)
    end

    it "responds to :comments" do
      expect(user).to respond_to(:comments)
    end

    it "responds to :initiated_friendings" do
      expect(user).to respond_to(:initiated_friendings)
    end

    it "responds to :friended_users" do
      expect(user).to respond_to(:friended_users)
    end

    it "responds to :received_friendings" do
      expect(user).to respond_to(:received_friendings)
    end

    it "responds to :users_friended_by" do
      expect(user).to respond_to(:users_friended_by)
    end
  end

  describe 'methods' do
    before do
      user.save!
    end

    it 'generates auth_token' do
      expect(user.auth_token).not_to be_nil
    end

    it 'regenerates different auth_token' do
      token = user.auth_token
      user.regenerate_auth_token
      expect(user.auth_token).not_to eq(token)
    end

    it 'has friend collection' do
      new_user = create(:user)
      user.friends = new_user
      expect(user.friends).to eq([new_user])
    end
  end
end