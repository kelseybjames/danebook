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
      assign(:post, create(:post, user: user))
      assign(:posts, posts)
      render
      expect(rendered).to match("#{posts.first.body}")
    end

    it 'current user can post on timeline' do
      assign(:user, user)
      assign(:post, Post.new(user: user))
      assign(:posts, posts)
      render
      expect(rendered).to match("Create Post")
    end

    it 'user can like timeline post' do
      assign(:user, user)
      assign(:post, Post.new(user: user))
      assign(:posts, posts)
      render
      expect(rendered).to match("Like")
    end

    it 'user can comment on timeline post' do
      assign(:user, user)
      assign(:post, Post.new(user: user))
      assign(:posts, posts)
      render
      expect(rendered).to match("Create Comment")
    end

    it 'current user can delete timeline post' do
      assign(:user, user)
      assign(:post, Post.new(user: user))
      assign(:posts, posts)
      render
      expect(rendered).to match("Delete")
    end
  end
end