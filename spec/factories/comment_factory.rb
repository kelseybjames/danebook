FactoryGirl.define do
  factory :post_comment, class: 'Comment' do
    body "This is a test comment."
    commentable_type 'Post'
    post
    author
  end
end