require 'rails_helper'

describe 'posts/index.html.erb' do
  let(:user){ create(:user) }
  let(:posts){ create_list(:post, 5, user: user) }

  before do
    user
    posts

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

    it 'logged in user can see posts' do
      assign(:user, user)
      assign(:posts, posts)
      render
      expect(rendered).to match("#{secret.author.name}")
    end
  end
end